import Foundation
import RxSwift

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
        getReactionTags()
    }
    
    lazy var reactionTags: Observable<[ReactionTag]> = {
        return tagsSubject
    }()
    
    func getReactionTags() {
        service.getReactionTags()
            .asObservable()
            .bind(to: tagsSubject)
            .disposed(by: disposeBag)
    }
}
