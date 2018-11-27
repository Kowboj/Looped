import Foundation
@testable import Looped

class MockAPIClient: APIClient {
    var isSendRequestCalled = false
    
    func send(request: APIRequest, completion: @escaping (Result<Data>) -> ()) {
        isSendRequestCalled = true
    }
}
