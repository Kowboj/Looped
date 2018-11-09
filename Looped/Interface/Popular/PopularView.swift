import UIKit

final class PopularView: View {
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.cyan
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private(set) lazy var popularInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "First tab - Popular - for not logged users.\n\nGet best giphs and present in the full screen list. Searcher on top?"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [tableView, popularInfoLabel].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
        backgroundColor = UIColor.brown
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        tableView.centerInSuperview(size: CGSize(width: 300, height: 500))
        popularInfoLabel.anchor(top: tableView.topAnchor, leading: tableView.leadingAnchor, trailing: tableView.trailingAnchor, bottom: tableView.bottomAnchor)
    }
}
