import Foundation
import RxSwift

protocol UserViewModelProtocol {
    func logout()
    func getUploadedGifs()
    func getBookmarkedGifs()
    
    var uploadedGifs: Observable<[GifViewModel]> { get }
    var bookmarkedGifs: Observable<[GifViewModel]> { get }
    var isLogged: Observable<Bool> { get }
}

final class UserViewModel: UserViewModelProtocol {
    
    init(service: UserGifsServiceProtocol, sessionProvider: SessionProviding) {
        self.service = service
        self.sessionProvider = sessionProvider
        checkIfIsLogged()
    }
    
    // MARK: - Properties
    
    private let service: UserGifsServiceProtocol
    private let sessionProvider: SessionProviding
    private let disposeBag = DisposeBag()
    private let uploadedGifsSubject = PublishSubject<[GifViewModel]>()
    private let bookmarkedGifsSubject = PublishSubject<[GifViewModel]>()
    private let isLoggedSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    // MARK: - UserViewModelProtocol
    
    lazy var uploadedGifs: Observable<[GifViewModel]> = {
        return uploadedGifsSubject
    }()
    
    lazy var bookmarkedGifs: Observable<[GifViewModel]> = {
        return bookmarkedGifsSubject
    }()
    
    lazy var isLogged: Observable<Bool> = {
        return isLoggedSubject
    }()
    
    func logout() {
        sessionProvider.deleteSession()
    }
    
    func getUploadedGifs() {
        service.fetchUploadedGifs()
            .asObservable()
            .bind(to: uploadedGifsSubject)
            .disposed(by: disposeBag)
    }
    
    func getBookmarkedGifs() {
        // TODO: get bookmarked gifs with service
    }
    
    // MARK: - Private
    
    private func checkIfIsLogged() {
        sessionProvider.currentSession
            .map { $0 != nil }
            .asObservable()
            .bind(to: isLoggedSubject)
            .disposed(by: disposeBag)
    }
}
