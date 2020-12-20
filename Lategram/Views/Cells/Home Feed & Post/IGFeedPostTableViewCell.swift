//
//  IGFeedPostTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/10/20.
//

import UIKit

// final so no one can subclass this....
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell...
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
