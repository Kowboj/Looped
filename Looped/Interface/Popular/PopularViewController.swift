import UIKit
import RxSwift
import RxCocoa

protocol PopularViewControllerFlowDelegate: class {
    func showDetails(gif: GifViewModel)
}

final class PopularViewController: ViewController {
    
    init(viewModel: PopularViewModelProtocol) {
        self.popularViewModel = viewModel
        super.init()
    }
    
    // MARK: - Properties
    
    private let popularViewModel: PopularViewModelProtocol
    private let popularView = PopularView()
    private let disposeBag = DisposeBag()
    weak var flowDelegate: PopularViewControllerFlowDelegate?
    
    // MARK: - Overrides
    
    override func loadView() {
        view = popularView
    }
    
    override func setupNavigationItem() {
        super.setupNavigationItem()
        navigationItem.titleView = popularView.searchBar
    }
    
    override func setupProperties() {
        super.setupProperties()
        popularView.tableView.refreshControl = popularView.refreshControl
        popularView.tableView.register(GifCell.self, forCellReuseIdentifier: GifCell.reuseIdentifier)
    }
    
    override func setupBindings() {
        super.setupBindings()

        popularViewModel.reactionTags
            .bind(to: popularView.tableView.rx.items(cellIdentifier: GifCell.reuseIdentifier, cellType: GifCell.self)) { _ , element, cell in
                let cellViewModel = GifCellViewModel(viewModel: element.gfycats.first!, reactionTag: element)
                cell.titleLabel.text = cellViewModel.title
                cell.likesLabel.text = cellViewModel.likes
                if let url = URL(string: cellViewModel.gifURLString) {
                    cell.openGifFrom(url: url)
                }
            }
            .disposed(by: disposeBag)

        popularView.tableView.rx.modelSelected(ReactionTag.self)
            .subscribe(onNext: { [weak self] tag in
                if let firstGif = tag.gfycats.first {
                    self?.flowDelegate?.showDetails(gif: firstGif)
                }
            })
            .disposed(by: disposeBag)

        popularView.refreshControl.rx.controlEvent(UIControl.Event.valueChanged)
            .map { [popularView] _ in !popularView.refreshControl.isRefreshing }
            .bind(to: popularView.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)

        popularView.refreshControl.rx.controlEvent(UIControl.Event.valueChanged)
            .debounce(2, scheduler: MainScheduler.instance)
            .filter { [popularView] _ in !popularView.refreshControl.isRefreshing }
            .subscribe(onNext: { [weak self] in
                self?.popularViewModel.getReactionTags()
            })
            .disposed(by: disposeBag)

        popularViewModel.isLoading
            .bind(to: popularView.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}
