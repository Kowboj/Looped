import RxSwift

protocol UserGifsServiceProtocol {
    func fetchUploadedGifs() -> Single<[GifViewModel]>
    func fetchBookmarkedGifs()
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
            .map { try JSONDecoder().decode(GfycatGifs.self, from: $0.data!) }
            .map { $0.gfycats }
            .asObservable()
            .asSingle()
    }
    
    func fetchBookmarkedGifs() {
        // TODO: Bookmarked gifs API call
    }
    
    // MARK: - Private
    
    private struct GfycatGifs: Decodable {
        let gfycats: [GifViewModel]
    }
}
