import UIKit
import RxSwift
import RxCocoa

protocol PopularViewModelProtocol {
    func getReactionTags() -> Driver<Bool>

    var reactionTags: Observable<[ReactionTag]> { get }
}

final class PopularViewModel: PopularViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private var service: ReactionTagsServiceProtocol
    private let tagsSubject = PublishSubject<[ReactionTag]>()
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service

        getReactionTags()
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: self.disposeBag)
    }
    
    lazy var reactionTags: Observable<[ReactionTag]> = {
        return tagsSubject
    }()
    
    func getReactionTags() -> Driver<Bool> {
        let activity = ActivityIndicator()
        service.getReactionTags()
            .trackActivity(activity)
            .asObservable()
            .bind(to: tagsSubject)
            .disposed(by: disposeBag)
        return activity.asDriver()
    }
}
