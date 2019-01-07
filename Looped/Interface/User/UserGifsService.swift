import RxSwift

protocol UserGifsServiceProtocol {
    func fetchUploadedGifs() -> Single<[GifViewModel]>
    func fetchLikedGifs() -> Single<[GifViewModel]>
}

final class UserGifsService: UserGifsServiceProtocol {
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Properties
    
    private let apiClient: APIClient
    
    // MARK: - UserGifsServiceProtocol
    
    func fetchUploadedGifs() -> Single<[GifViewModel]> {
        return apiClient.send(request: UploadedRequest())
            .filter { $0.data != nil }
            .map { try JSONDecoder().decode(UserGifs.self, from: $0.data!) }
            .map { $0.gfycats }
            .asObservable()
            .asSingle()
    }
    
    func fetchLikedGifs() -> Single<[GifViewModel]> {
        return apiClient.send(request: LikedRequest())
            .filter { $0.data != nil }
            .map { try JSONDecoder().decode(UserGifs.self, from: $0.data!) }
            .map { $0.gfycats }
            .asObservable()
            .asSingle()
    }
    
    // MARK: - Private
    
    private struct UserGifs: Decodable {
        let gfycats: [GifViewModel]
    }
}
