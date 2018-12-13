import UIKit
import RxSwift
import RxCocoa

protocol PopularViewModelProtocol {
    func getReactionTags()

    var reactionTags: Observable<[ReactionTag]> { get }
}

final class PopularViewModel: PopularViewModelProtocol {
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service
        getReactionTags()
    }
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let service: ReactionTagsServiceProtocol
    private let tagsSubject = PublishSubject<[ReactionTag]>()
    
    // MARK: - PopularViewModelProtocol
    
    lazy var reactionTags: Observable<[ReactionTag]> = {
        return tagsSubject
    }()
    
    func getReactionTags() {
        let activity = ActivityIndicator()
        service.getReactionTags()
            .trackActivity(activity)
            .asObservable()
            .bind(to: tagsSubject)
            .disposed(by: disposeBag)
    }
}
