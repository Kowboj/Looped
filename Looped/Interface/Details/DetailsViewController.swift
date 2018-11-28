import UIKit
import RxSwift

final class DetailsViewController: ViewController {
    
    // MARK: - Properties
    private let detailsView = DetailsView()
    private let gif: String
    weak var popularFlowDelegate: PopularViewControllerFlowDelegate?
    weak var userFlowDelegate: UserViewControllerFlowDelegate?
    let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    init(gif: String) {
        self.gif = gif
        super.init()
    }
    
    // MARK: - Overrides
    override func loadView() {
        view = detailsView
    }
    
    override func setupProperties() {
        super.setupProperties()
        detailsView.detailsInfoLabel.text = gif
        
        // RxSwift text
        let observable = Observable<String>.create { (observer) -> Disposable in
            DispatchQueue.global(qos: .default).async {
                Thread.sleep(forTimeInterval: 3)
                observer.onNext("Updated using Rx")
                observer.onCompleted()
            }
            return Disposables.create {
                print("disposing")
            }
        }.observeOn(MainScheduler.instance)
        
        observable.subscribe(onNext: { [unowned self] (element) in
            self.detailsView.detailsInfoLabel.text = element
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }.disposed(by: disposeBag)
    }
}
