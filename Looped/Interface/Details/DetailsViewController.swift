import UIKit
import RxSwift

protocol DetailsViewControllerFlowDelegate: class {
    func didTapDetails()
}

final class DetailsViewController: ViewController {
    
    // MARK: - Properties
    private let detailsView = DetailsView()
    private let disposeBag = DisposeBag()
    private let viewModel: DetailsViewModelProtocol

    weak var delegate: DetailsViewControllerFlowDelegate?
    
    // MARK: - Initializers
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Overrides
    override func loadView() {
        view = detailsView
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.userName
            .bind(to: detailsView.detailsInfoLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
