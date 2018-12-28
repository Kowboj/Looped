import Foundation
import RxSwift

protocol RegisterServiceProtocol {
    func authenticate() -> Single<Session>
    func register(userName: String, password: String) -> Single<Session>
}

final class RegisterService: RegisterServiceProtocol {
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Properties
    
    private let apiClient: APIClient
    
    // MARK: - Public
    
    func register(userName: String, password: String) -> Single<Session> {
        return apiClient.send(request: RegisterRequest(userName: userName, password: password))
            .map { try JSONDecoder().decode(LoginResponse.self, from: $0.data!) }
            .map { Session(token: $0.access_token, refreshToken: $0.refresh_token) }
            .asObservable()
            .asSingle()
    }
    
    func authenticate() -> Single<Session> {
        return apiClient.send(request: AuthenticateRequest())
            .map { try JSONDecoder().decode(LoginResponse.self, from: $0.data!) }
            .map { Session(token: $0.access_token, refreshToken: $0.refresh_token) }
            .asObservable()
            .asSingle()
    }
}
