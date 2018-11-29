import Foundation
import RxSwift

protocol PopularViewModelProtocol {
    var reactionTags: Observable<[ReactionTag]> { get }
}

final class PopularViewModel: PopularViewModelProtocol {
    
    private var service: ReactionTagsServiceProtocol
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service
    }
    
    lazy var reactionTags: Observable<[ReactionTag]> = {
        return service.getReactionTags().asObservable()
    }()
}
