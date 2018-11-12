import UIKit

extension UIView {
    
    func centerInSuperview(padding: CGFloat = 0) {

        if let superview = superview {
            NSLayoutConstraint.activate([
                widthAnchor.constraint(equalToConstant: superview.frame.size.width - padding*2),
                heightAnchor.constraint(equalToConstant: superview.frame.size.height - padding*2),
                centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                centerYAnchor.constraint(equalTo: superview.centerYAnchor)
                                        ])
        }
        
    }
    
    func anchorSize(to view: UIView) {
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: view.widthAnchor),
            heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        if let top = top {
            NSLayoutConstraint.activate([topAnchor.constraint(equalTo: top, constant: padding.top)])
        }
        
        if let leading = leading {
            NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: leading, constant: padding.left)])
        }
        
        if let trailing = trailing {
            NSLayoutConstraint.activate([trailingAnchor.constraint(equalTo: trailing, constant: padding.right)])
        }
        
        if let bottom = bottom {
            NSLayoutConstraint.activate([bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom)])
        }
        
        if size.width != 0 {
            NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: size.width)])
        }
        
        if size.height != 0 {
            NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: size.height)])
        }
    }
}
