import Foundation

protocol ReactionTagsServiceProtocol {
    func getReactionTags(completion: @escaping (Result<[ReactionTag]>) -> Void)
}

final class ReactionTagsService: ReactionTagsServiceProtocol {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getReactionTags(completion: @escaping (Result<[ReactionTag]>) -> Void) {
        apiClient.send(request: ReactionTagsRequest()) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(ReactionTagsResponse.self, from: data)
                    // TODO: - Save to Realm
                    completion(Result.success(model.tags))
                } catch let jsonError {
                    completion(Result.failure(jsonError))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
