import RxSwift

protocol APIClient {
    func send(request: APIRequest) -> Single<APIResponse>
}
