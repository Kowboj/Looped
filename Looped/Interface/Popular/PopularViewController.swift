import UIKit
import RxSwift
import RxCocoa

protocol PopularViewControllerFlowDelegate: class {
    func showDetails(gif: String)
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
    private var reactionTags: [ReactionTag] = [] {
        didSet {
            DispatchQueue.main.async {
                self.popularView.tableView.reloadData()
            }
        }
    }
    
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
        popularView.tableView.register(GifCell.self, forCellReuseIdentifier: GifCell.reuseIdentifier)
        setupBindings()
    }
    
    // MARK: - Private
    
    private func setupBindings() {
        
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
                self?.flowDelegate?.showDetails(gif: tag.tag)
            })
            .disposed(by: disposeBag)
    }
}
