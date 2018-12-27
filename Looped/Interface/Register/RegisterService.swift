import Foundation
import RxSwift

protocol RegisterServiceProtocol {
    func register(username: String, password: String) -> Single<String>
}

final class RegisterService: RegisterServiceProtocol {
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Properties
    
    private let apiClient: APIClient
    
    // MARK: - Public
    
    func register(username: String, password: String) -> Single<String> {
        return apiClient.send(request: RegisterRequest(username: username, password: password))
            .filter { $0.data != nil }
            .map { try JSONDecoder().decode(RegisterResponse.self, from: $0.data!) }
            .map { ($0.errorMessage != nil) ? $0.errorMessage?.description ?? "Error" : "Success" }
            .asObservable()
            .asSingle()
    }
    
    // MARK: - Private
    
    private struct RegisterResponse: Decodable {
        let errorMessage: ErrorMessage?
    }
    private struct ErrorMessage: Decodable {
        let code: String
        let description: String
    }
    
}
