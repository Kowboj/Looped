import XCTest
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

class PopularViewModelTests: XCTestCase {
    var apiError: APIError?
    var mockReactionTagsService: MockReactionTagsService?
    var sut: PopularViewModelProtocol?
    
    override func setUp() {
        super.setUp()
        apiError = APIError.incorrectURL(url: "")
        mockReactionTagsService = MockReactionTagsService()
        sut = PopularViewModel(service: mockReactionTagsService!)
    }
    
    func testGetReactionTags() {
        sut!.getReactionTags { (tags, error) in }
        XCTAssert(mockReactionTagsService!.isGetReactionTagsCalled)
    }
    
    func testGetSuccess() {
        mockReactionTagsService?.getSuccess()
        sut!.getReactionTags { (tags, error) in
            XCTAssert(error == nil)
        }
    }
    
    func testGetFailure() {
        mockReactionTagsService?.getFailure(error: apiError!)
        sut!.getReactionTags { (tags, error) in
            XCTAssert(error != nil)
        }
    }

    override func tearDown() {
        mockReactionTagsService = nil
        sut = nil
    }
}
