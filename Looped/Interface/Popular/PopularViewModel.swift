import Foundation

protocol PopularViewModelProtocol {
    func getReactionTags(completion: @escaping ([ReactionTag], Error?) -> Void)
}

final class PopularViewModel: PopularViewModelProtocol {
    
    private var service: ReactionTagsServiceProtocol
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service
    }
    
    func getReactionTags(completion: @escaping ([ReactionTag], Error?) -> Void) {
        service.getReactionTags { (result) in
            switch result {
            case .success(let tags):
                completion(tags, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
}
