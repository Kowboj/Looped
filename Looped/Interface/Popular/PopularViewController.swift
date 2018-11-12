import UIKit

protocol PopularViewControllerFlowDelegate: class, DetailsShowable {}

final class PopularViewController: ViewController {
    
    // MARK: - Properties
    private let popularView = PopularView()
    weak var flowDelegate: PopularViewControllerFlowDelegate?
    
    // MARK: - Overrides
    override func loadView() {
        view = popularView
    }
    
    override func setupProperties() {
        super.setupProperties()
        popularView.tableView.delegate = self
        popularView.tableView.dataSource = self
    }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flowDelegate?.showDetails(gif: "Selected Gif \(indexPath.row)")
    }
}
