import Foundation
import RxSwift

protocol UserViewModelProtocol {
    func getLikedReactionTags()
    func getUploadedReactionTags()
    
    var likedReactionTags: Observable<[ReactionTag]> { get }
    var uploadedReactionTags: Observable<[ReactionTag]> { get }
}

final class UserViewModel: UserViewModelProtocol {
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service
        getLikedReactionTags()
    }
    
    private let disposeBag = DisposeBag()
    private let service: ReactionTagsServiceProtocol
    private let likedTagsSubject = PublishSubject<[ReactionTag]>()
    private let uploadedTagsSubject = PublishSubject<[ReactionTag]>()
    
    lazy var likedReactionTags: Observable<[ReactionTag]> = {
       return likedTagsSubject
    }()
    
    lazy var uploadedReactionTags: Observable<[ReactionTag]> = {
        return uploadedTagsSubject
    }()
    
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
}
