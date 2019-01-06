import Foundation
import RxSwift

protocol UserViewModelProtocol {
    func logout()
    func getLikedReactionTags()
    func getUploadedReactionTags()
    
    var likedReactionTags: Observable<[ReactionTag]> { get }
    var uploadedReactionTags: Observable<[ReactionTag]> { get }
    var isLogged: Observable<Bool> { get }
}

final class UserViewModel: UserViewModelProtocol {
    
    init(service: ReactionTagsServiceProtocol, sessionProvider: SessionProviding) {
        self.service = service
        self.sessionProvider = sessionProvider
        checkIfIsLogged()
    }
    
    // MARK: - Properties
    
    private let service: ReactionTagsServiceProtocol
    private let sessionProvider: SessionProviding
    private let disposeBag = DisposeBag()
    private let likedTagsSubject = PublishSubject<[ReactionTag]>()
    private let uploadedTagsSubject = PublishSubject<[ReactionTag]>()
    private let isLoggedSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    // MARK: - UserViewModelProtocol
    
    lazy var likedReactionTags: Observable<[ReactionTag]> = {
       return likedTagsSubject
    }()
    
    lazy var uploadedReactionTags: Observable<[ReactionTag]> = {
        return uploadedTagsSubject
    }()
    
    lazy var isLogged: Observable<Bool> = {
        return isLoggedSubject
    }()
    
    func logout() {
        sessionProvider.deleteSession()
    }
    
    func getLikedReactionTags() {
        service.getReactionTags() // TODO: Add proper API method (getLiked)
            .asObservable()
            .bind(to: likedTagsSubject)
            .disposed(by: disposeBag)
    }
    
    func getUploadedReactionTags() {
        service.getReactionTags() // TODO: Add proper API method (getUploaded)
            .asObservable()
            .bind(to: uploadedTagsSubject)
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
