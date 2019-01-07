import Foundation
import RxSwift
import RxCocoa

protocol UserViewModelProtocol {
    func logout()
    func getUploadedGifs()
    func getLikedGifs()
    
    var userGifs: Observable<[GifViewModel]> { get }
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
    private let isLoggedSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    private let userGifsRelay = PublishRelay<[GifViewModel]>()
    
    // MARK: - UserViewModelProtocol
    
    lazy var userGifs: Observable<[GifViewModel]> = {
        return userGifsRelay.asObservable()
    }()
    
    lazy var isLogged: Observable<Bool> = {
        return isLoggedSubject
    }()
    
    func logout() {
        userGifsRelay.accept([])
        sessionProvider.deleteSession()
    }
    
    func getUploadedGifs() {
        service.fetchUploadedGifs()
            .asObservable()
            .bind(to: userGifsRelay)
            .disposed(by: disposeBag)
    }
    
    func getLikedGifs() {
        service.fetchLikedGifs()
            .asObservable()
            .bind(to: userGifsRelay)
            .disposed(by: disposeBag)
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
