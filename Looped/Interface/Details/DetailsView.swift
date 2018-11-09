import UIKit

final class DetailsView: View {
    
    private(set) lazy var detailsInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [detailsInfoLabel].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
        backgroundColor = .lightGray
    }
}
