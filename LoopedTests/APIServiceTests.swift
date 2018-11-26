import XCTest
@testable import Looped

struct MockAPIService: APIService {
    var host: String
    var root: String
}

class APIServiceTests: XCTestCase {

    var sut: APIService!
    
    override func setUp() {
        sut = MockAPIService(host: "testHost", root: "testRoot")
    }
    
    func testHostAndRoot() {
        XCTAssertEqual(sut.host, "testHost")
        XCTAssertEqual(sut.root, "testRoot")
    }

    func testScheme() {
        XCTAssertEqual(sut.scheme.rawValue, "http")
    }
    
    override func tearDown() {
        sut = nil
    }
}
