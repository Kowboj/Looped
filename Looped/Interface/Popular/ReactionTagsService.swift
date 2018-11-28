import Foundation
import RxSwift

protocol ReactionTagsServiceProtocol {
    func getReactionTags() -> Single<[ReactionTag]>
}

final class ReactionTagsService: ReactionTagsServiceProtocol {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getReactionTags() -> Single<[ReactionTag]> {
        return apiClient.send(request: ReactionTagsRequest())
            .filter { $0.data != nil }
            .map { try JSONDecoder().decode(ReactionTagsResponse.self, from: $0.data!) }
            .map { $0.tags }
            .asObservable()
            .asSingle()
    }
}
