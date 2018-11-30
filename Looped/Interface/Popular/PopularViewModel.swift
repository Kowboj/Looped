import Foundation
import RxSwift

protocol PopularViewModelProtocol {
    func getReactionTags()

    var reactionTags: Observable<[ReactionTag]> { get }
}

final class PopularViewModel: PopularViewModelProtocol {
    
    private var service: ReactionTagsServiceProtocol

    private let tagsSubject = PublishSubject<[ReactionTag]>()
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service
    }
    
    lazy var reactionTags: Observable<[ReactionTag]> = {
        return tagsSubject
    }()

    func getReactionTags() {
        let tags = service.getReactionTags().asObservable()
        let array = [ReactionTag]()
        tagsSubject.onNext(array)
    }
}
