import UIKit

protocol PopularViewControllerFlowDelegate: class {
    func showDetails(gif: String)
}

final class PopularViewController: ViewController {
    
    init(viewModel: PopularViewModel) {
        self.popularViewModel = viewModel
        super.init()
    }
    
    // MARK: - Properties
    private let popularViewModel: PopularViewModel
    private let popularView = PopularView()
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
        popularViewModel.getReactionTags { (tags) in
            self.reactionTags = tags
            DispatchQueue.main.async {
                self.popularView.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private
    private func setupTableView() {
        popularView.tableView.register(GifCell.self, forCellReuseIdentifier: GifCell.reuseIdentifier)
        popularView.tableView.delegate = self
        popularView.tableView.dataSource = self
    }
}

extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Push to details or show more gifs of this tag in the same tableView
    }
}

extension PopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GifCell.reuseIdentifier) as? GifCell {
            let currentTag = reactionTags[indexPath.row]
            if let firstGif = currentTag.gfycats.first {
                let cellViewModel = GifCellViewModel(viewModel: firstGif, reactionTag: currentTag)
                cell.titleLabel.text = cellViewModel.title
                cell.likesLabel.text = cellViewModel.likes
                if let url = URL(string: cellViewModel.gifURLString) {
                    cell.openGifFrom(url: url)
                }
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
