import XCTest
@testable import Looped

class ReactionTagsRequestTests: XCTestCase {

    var defaultAPIClient: DefaultAPIClient!
    var sut: ReactionTagsRequest!
    
    override func setUp() {
        super.setUp()
        defaultAPIClient = DefaultAPIClient()
        sut = ReactionTagsRequest()
    }

    override func tearDown() {
        super.tearDown()
        defaultAPIClient = nil
        sut = nil
    }

    func testReactionTagsRequest() {
        defaultAPIClient.send(request: sut, completion: { (result) in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(ReactionTagsResponse.self, from: data)
                    XCTAssert(model.tags.count > 1)
                } catch _ {
                    XCTFail()
                }
            case .failure( _):
                XCTFail()
            }
        })
    }
}
