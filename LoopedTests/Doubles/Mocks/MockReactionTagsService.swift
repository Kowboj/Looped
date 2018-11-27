import Foundation
@testable import Looped

class MockReactionTagsService: ReactionTagsServiceProtocol {
    var isGetReactionTagsCalled = false
    var result: Result<[ReactionTag]>?
    
    func getReactionTags(completion: @escaping (Result<[ReactionTag]>) -> Void) {
        isGetReactionTagsCalled = true
        if result != nil {
            completion(result!)
        }
    }
    
    func getSuccess() {
        result = Result.success([])
    }
    
    func getFailure(error: APIError) {
        result = Result.failure(error)
    }
}
