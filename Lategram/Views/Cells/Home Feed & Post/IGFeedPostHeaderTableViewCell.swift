//
//  IGFeedPostHeaderTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/10/20.
//

import SDWebImage
import UIKit

// Implementing the delegate to active the button
protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    
    func didTapMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    // Create subviews
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    // Adding the Label here
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
        
    }()
    
    // Add Button here
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
        
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Add the subviews here
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        
    }
    
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User) {
        // configure the cell...
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
        
        
        // Content coming from the Firebase database here
        
        
        
       // profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout each of the subviews
        let size = contentView.height-4
        profilePhotoImageView.frame = CGRect(x: 2,
                                             y: 2,
                                             width: size,
                                             height: size)
        
        profilePhotoImageView.layer.cornerRadius = size/2
        
        // Button is setup here
        moreButton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
        
        usernameLabel.frame = CGRect(x: profilePhotoImageView.rigth+10,
                                     y: 2,
                                     width: contentView.width-(size*2)-15,
                                     height: contentView.height-4)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }

}


