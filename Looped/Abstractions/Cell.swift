import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        setupProperties()
        setupLayoutConstraints()
    }
    
    func setupViewHierarchy() {}
    func setupProperties() {}
    func setupLayoutConstraints() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewCell: Reusable {}


