import UIKit

class TableView1: UITableView {

    var heightConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        if heightConstraint == nil {
            if let imageView = header.subviews.first as? UIImageView {
                heightConstraint = imageView.constraints.filter{ $0.identifier == "height" }.first
                bottomConstraint = header.constraints.filter{ $0.identifier == "bottom" }.first
            }
        }

        let offsetY = -contentOffset.y//
        
        heightConstraint?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        bottomConstraint?.constant = offsetY >= 0 ? 0 : offsetY / 4

        header.clipsToBounds = offsetY <= 0
    }
}

