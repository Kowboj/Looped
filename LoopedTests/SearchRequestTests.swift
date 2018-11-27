import XCTest
@testable import Looped

final class SearchRequestTest: XCTestCase {
    
    var sut: SearchRequest!
    
    override func setUp() {
        super.setUp()
        sut = SearchRequest(text: "test")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testProperties() {
        XCTAssertEqual(sut.path, "search")
        XCTAssertEqual(sut.method, .GET)
    }
    func testQuery() {
        var query: [String : APIQueryParameter] {
            return ["search_text" : .string("test")]
        }
        XCTAssertEqual(sut.query, query)
    }
}
