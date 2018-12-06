import UIKit
import RxSwift
import RxCocoa

protocol PopularViewModelProtocol {
    func getReactionTags()

    var reactionTags: Observable<[ReactionTag]> { get }
}

final class PopularViewModel: PopularViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private var service: ReactionTagsServiceProtocol
    private let tagsSubject = PublishSubject<[ReactionTag]>()
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service
    }
    
    lazy var reactionTags: Observable<[ReactionTag]> = {
        return tagsSubject
    }()
    
    func getReactionTags() {
        let activity = ActivityIndicator()
        service.getReactionTags()
            .trackActivity(activity)
            .asObservable()
            .bind(to: tagsSubject)
            .disposed(by: disposeBag)
    }
}
