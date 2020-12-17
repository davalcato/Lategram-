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
    func didTapFollowUnfollowButton(model: UserRelationship)
}

// Things to configure (username, button, and profileImageView) goes here...
enum FollowState {
    case following, not_following
    
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
    
}

class UserFollowTableViewCell: UITableViewCell {

   static let identifier = "UserFollowTableViewCell"
    
    // The weak delegate here
    weak var delegate: UserFollowTableViewCellDelegate?
    
    // Holding on to the model here from the configure(with model:
    private var model: UserRelationship?
    
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
        label.textColor = .secondaryLabel
     
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
        // change the highlight of the selected button on the follower button
        selectionStyle = .none
        
        // Hooking up the button here
        followButton.addTarget(self,
                               action: #selector(didTapFollowButton),
                               for: .touchUpInside)
        
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
            
            
        }
        
        delegate?.didTapFollowUnfollowButton(model: model)
        
    }
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        
        }
        
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
                                    y: (contentView.height-40)/2,
                                    width: buttonWidth,
                                    height: 40)
        
        
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
