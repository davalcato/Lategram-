//
//  UserFollowTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/16/20.
//

import UIKit

// Adding the Delegate here and having it conform to AnyObject/ otherwise you can't be a weak property
protocol UserFollowTableViewCellDelegate: AnyObject {
    // Passing in the model here
    func didTapFollowUnfollowButton(model: String)
}

class UserFollowTableViewCell: UITableViewCell {

   static let identifier = "UserFollowTableViewCell"
    
    // The weak delegate here
    weak var delegate: UserFollowTableViewCellDelegate?
    
    // Add subviews here
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        // Otherwise circle wouldn't show up
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemBackground
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Joie Chavez"
     
        return label
        
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@Joie"
     
        return label
        
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        
        // Adding subviews here...
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        
    }
    
    public func configure(with model: String) {
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Layout subview here
    override func layoutSubviews() {
        super.layoutSubviews()
        // Circle here
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        // Reference the button size here
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                    y: 5,
                                    width: buttonWidth,
                                    height: contentView.height-10)
        
        
        // The two labels go here
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.rigth+5,
                                 y: 0,
                                 width: contentView.width-8-profileImageView.width,
                                 height: labelHeight)
        
        usernameLabel.frame = CGRect(x: profileImageView.rigth+5,
                                     y: nameLabel.bottom,
                                 width: contentView.width-8-profileImageView.width-buttonWidth,
                                 height: labelHeight)
        
    }
}
