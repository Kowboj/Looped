import UIKit

protocol UserViewControllerFlowDelegate: class {
    func showDetails(gif: String)
    func presentLogin()
}

final class UserViewController: ViewController {
    
    // MARK: - Properties
    private let userView = UserView()
    weak var flowDelegate: UserViewControllerFlowDelegate?
    
    // MARK: - Overrides
    override func loadView() {
        view = userView
    }
    
    override func setupNavigationItem() {
        super.setupNavigationItem()
        navigationItem.title = "Arnold Kangur"
    }
    
    override func setupProperties() {
        super.setupProperties()
        userView.loginButton.addTarget(self, action: #selector(loginTapped), for: UIControl.Event.touchUpInside)
        setupSegmentedControl()
        setupTableView()
    }
    
    // MARK: - Private
    
    private func setupSegmentedControl() {
        userView.segmentedControl.setTitle("My GIFs", forSegmentAt: 0)
        userView.segmentedControl.setTitle("Favorites", forSegmentAt: 1)
        userView.segmentedControl.addTarget(self, action: #selector(segmentedTapped), for: .valueChanged)
    }
    
    private func setupTableView() {
        userView.tableView.register(GifCell.self, forCellReuseIdentifier: GifCell.reuseIdentifier)
        userView.tableView.delegate = self
        userView.tableView.dataSource = self
    }
    
    @objc private func segmentedTapped(sender: UISegmentedControl) {
        // TODO: - Create two dataSource objects?
        userView.tableView.reloadData()
    }
    
    @objc private func loginTapped() {
        flowDelegate?.presentLogin()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GifCell.reuseIdentifier) as? GifCell {
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flowDelegate?.showDetails(gif: "Selected Gif \(indexPath.row)")
    }
}
