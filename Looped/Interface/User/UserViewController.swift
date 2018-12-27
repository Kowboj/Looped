import UIKit
import RxSwift

protocol UserViewControllerFlowDelegate: class {
    func showDetails(gif: GifViewModel)
    func presentLogin()
    func presentRegister()
}

final class UserViewController: ViewController {
    
    init(userViewModel: UserViewModelProtocol) {
        self.userViewModel = userViewModel
        super.init()
        userViewModel.getLikedReactionTags()
    }
    
    // MARK: - Properties
    
    private let userViewModel: UserViewModelProtocol
    private let userView = UserView()
    private let disposeBag = DisposeBag()
    weak var flowDelegate: UserViewControllerFlowDelegate?
    
    // MARK: - Overrides
    
    override func loadView() {
        view = userView
    }
    
    override func setupProperties() {
        super.setupProperties()
        userView.tableView.register(GifCell.self, forCellReuseIdentifier: GifCell.reuseIdentifier)
        setupSegmentedControl()

    }
    
    override func setupBindings() {
        super.setupBindings()
        
        userViewModel.isLogged
            .bind(to: userView.loginButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        userViewModel.isLogged
            .bind(to: userView.registerButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        userViewModel.likedReactionTags
            .bind(to: userView.tableView.rx.items(cellIdentifier: GifCell.reuseIdentifier, cellType: GifCell.self)) { _ , element, cell in
                let cellViewModel = GifCellViewModel(viewModel: element.gfycats.first!, reactionTag: nil)
                cell.titleLabel.text = cellViewModel.title
                cell.likesLabel.text = cellViewModel.likes
                if let url = URL(string: cellViewModel.gifURLString) {
                    cell.openGifFrom(url: url)
                }
            }
            .disposed(by: disposeBag)
        
        userViewModel.uploadedReactionTags
            .bind(to: userView.tableView.rx.items(cellIdentifier: GifCell.reuseIdentifier, cellType: GifCell.self)) { _ , element, cell in
                let cellViewModel = GifCellViewModel(viewModel: element.gfycats.first!, reactionTag: nil)
                cell.titleLabel.text = cellViewModel.title
                cell.likesLabel.text = cellViewModel.likes
                if let url = URL(string: cellViewModel.gifURLString) {
                    cell.openGifFrom(url: url)
                }
            }
            .disposed(by: disposeBag)
        
        userView.tableView.rx.modelSelected(ReactionTag.self)
            .subscribe(onNext: { [weak self] tag in
                if let firstGif = tag.gfycats.first {
                    self?.flowDelegate?.showDetails(gif: firstGif)
                }
            })
            .disposed(by: disposeBag)
        
        Observable.just("Arnold Kangur")
            .bind(to: rx.title)
            .disposed(by: disposeBag)
        
        userView.loginButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.flowDelegate?.presentLogin()
            })
            .disposed(by: disposeBag)
        
        userView.registerButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.flowDelegate?.presentRegister()
            })
            .disposed(by: disposeBag)
        
        userView.segmentedControl.rx.controlEvent(UIControl.Event.valueChanged)
            .withLatestFrom(userView.segmentedControl.rx.value)
            .map { (selectedIndex) in
                switch selectedIndex {
                case 0:
                    self.userViewModel.getLikedReactionTags()
                case 1:
                    self.userViewModel.getUploadedReactionTags()
                default:
                    break
                }
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    // MARK: - Private
    
    private func setupSegmentedControl() {
        userView.segmentedControl.setTitle("My GIFs", forSegmentAt: 0)
        userView.segmentedControl.setTitle("Favorites", forSegmentAt: 1)
    }
}
