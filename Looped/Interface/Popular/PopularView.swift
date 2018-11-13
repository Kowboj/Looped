import UIKit

final class PopularView: View {
    
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search..."
        searchBar.barTintColor = UIColor.init(white: 0.9, alpha: 0.9)
        return searchBar
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [tableView].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        tableView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .zero, size: CGSize.zero)
    }
}
