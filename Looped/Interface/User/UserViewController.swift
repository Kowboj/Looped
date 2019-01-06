import UIKit
import RxSwift

protocol UserViewControllerFlowDelegate: class {
    func showDetails(gif: GifViewModel)
    func presentLogin(delegate: LoginViewControllerDelegate)
    func dismissLogin()
    func presentRegister()
}

final class UserViewController: ViewController {
    
    init(userViewModel: UserViewModelProtocol) {
        self.userViewModel = userViewModel
        super.init()
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
            .map { !$0 }
            .bind(to: userView.logoutButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        userViewModel.isLogged
            .bind(to: userView.loginButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        userViewModel.isLogged
            .bind(to: userView.registerButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        userViewModel.uploadedGifs
            .bind(to: userView.tableView.rx.items(cellIdentifier: GifCell.reuseIdentifier, cellType: GifCell.self)) { _ , element, cell in
                let cellViewModel = GifCellViewModel(viewModel: element, reactionTag: nil)
                cell.titleLabel.text = cellViewModel.title
                cell.likesLabel.text = cellViewModel.likes
                if let url = URL(string: cellViewModel.gifURLString) {
                    cell.openGifFrom(url: url)
                }
            }
            .disposed(by: disposeBag)
        
        Observable.just("User")
            .bind(to: rx.title)
            .disposed(by: disposeBag)
        
        userView.logoutButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.userViewModel.logout()
            })
            .disposed(by: disposeBag)
        
        userView.loginButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.flowDelegate?.presentLogin(delegate: self)
            })
            .disposed(by: disposeBag)
        
        userView.registerButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.flowDelegate?.presentRegister()
            })
            .disposed(by: disposeBag)
        
        userView.segmentedControl.rx.controlEvent(UIControl.Event.valueChanged)
            .withLatestFrom(userViewModel.isLogged)
            .filter { $0 == true }
            .withLatestFrom(userView.segmentedControl.rx.value)
            .map { (selectedIndex) in
                switch selectedIndex {
                case 0:
                    self.userViewModel.getUploadedGifs()
                case 1:
                    self.userViewModel.getBookmarkedGifs()
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
        userView.segmentedControl.setTitle("Saved", forSegmentAt: 1)
    }
}

extension UserViewController: LoginViewControllerDelegate {
    func dismiss() {
        flowDelegate?.dismissLogin()
    }
}
