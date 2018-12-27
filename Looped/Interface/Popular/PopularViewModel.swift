import UIKit
import RxSwift
import RxCocoa

protocol PopularViewModelProtocol {
    func getReactionTags()

    var reactionTags: Observable<[ReactionTag]> { get }
    var isLoading: Observable<Bool> { get }
}

final class PopularViewModel: PopularViewModelProtocol {
    
    init(service: ReactionTagsServiceProtocol) {
        self.service = service
        getReactionTags()
    }
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let activity = ActivityIndicator()
    private let service: ReactionTagsServiceProtocol
    private let tagsSubject = PublishSubject<[ReactionTag]>()
    
    // MARK: - PopularViewModelProtocol
    
    lazy var reactionTags: Observable<[ReactionTag]> = {
        return tagsSubject
    }()

    var isLoading: Observable<Bool> {
        return activity.asSharedSequence().asObservable()
    }
    
    func getReactionTags() {
        service.getReactionTags()
            .trackActivity(activity)
            .asObservable()
            .bind(to: tagsSubject)
            .disposed(by: disposeBag)
    }
}
