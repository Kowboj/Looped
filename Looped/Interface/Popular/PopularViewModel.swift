import Foundation

final class PopularViewModel {
    
    private let service: ReactionTagsService
    
    init(service: ReactionTagsService) {
        self.service = service
    }
    
    func getReactionTags(completion: @escaping ([ReactionTag]) -> Void) {
        service.getReactionTags(completion: completion)
    }
}
