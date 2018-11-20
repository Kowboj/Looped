import UIKit

protocol PopularViewControllerFlowDelegate: class {
    func showDetails(gif: String)
}

final class PopularViewController: ViewController {
    
    // MARK: - Properties
    private let popularView = PopularView()
    private let apiClient = DefaultAPIClient()
    weak var flowDelegate: PopularViewControllerFlowDelegate?
    private var reactionTags: [ReactionTag] = []
    
    // MARK: - Overrides
    override func loadView() {
        view = popularView
    }
    
    override func setupNavigationItem() {
        super.setupNavigationItem()
        navigationItem.titleView = popularView.searchBar
    }
    
    override func setupProperties() {
        super.setupProperties()
        setupTableView()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        getReactionTags { (tags) in
            self.reactionTags = tags
            DispatchQueue.main.async {
                self.popularView.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    // MARK: - Private
    private func setupTableView() {
        popularView.tableView.register(GifCell.self, forCellReuseIdentifier: GifCell.reuseIdentifier)
        popularView.tableView.delegate = self
        popularView.tableView.dataSource = self
    }
    
    private func getReactionTags(completion: @escaping ([ReactionTag]) -> Void) {
        apiClient.send(request: ReactionTagsRequest()) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(ReactionTagsResponse.self, from: data)
                    // TODO: - Save to Realm
                    completion(model.tags)
                } catch let jsonError {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print(jsonError)
                }
            case .failure(let error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print(error)
            }
        }
    }
}

extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        flowDelegate?.showDetails(gif: gifUrlStrings[indexPath.row])
    }
}

extension PopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GifCell.reuseIdentifier) as? GifCell {
            let currentTag = reactionTags[indexPath.row]
            cell.reactionTag = currentTag
            if let firstGif = currentTag.gfycats.first {
                cell.gifViewModel = firstGif
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactionTags.count
    }
}
