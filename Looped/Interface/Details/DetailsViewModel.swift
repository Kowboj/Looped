import RxSwift

protocol DetailsViewModelProtocol {
    var title: Observable<String> { get }
    var userName: Observable<String> { get }
    var gifUrl: Observable<String> { get }
}

final class DetailsViewModel: DetailsViewModelProtocol {

    private let gif: GifViewModel

    init(gif: GifViewModel) {
        self.gif = gif
    }

    lazy var title: Observable<String> = {
        return .just(gif.title)
    }()

    lazy var userName: Observable<String> = {
        return .just(gif.userName)
    }()

    lazy var gifUrl: Observable<String> = {
        return .just(gif.gifUrl)
    }()
}
