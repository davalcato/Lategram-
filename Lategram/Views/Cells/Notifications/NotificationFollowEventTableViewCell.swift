//
//  NotificationFollowEventTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/16/20.
//

import UIKit

// The controllers handles the delegate here
protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    // Update the delegate model to be UserNotification
    func didTapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    // Add the UserNotification model here as well
    private var model: UserNotification?
    
    // Add the subviews here...
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Beyonce started following you!"
      
        return label
        
    }()
    
    // The follow button goes here...
    private let followButton: UIButton = {
        let button = UIButton()
        return button
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            
            return
        }
        // Using the delegate to say didTapFollowUnFollowButton
        delegate?.didTapFollowUnFollowButton(model: model)
        
    }
    
    // Configure func to pass in a view model
    public func configure(with model: UserNotification) {
        // Retaining the model
        self.model = model
        
        switch model.type {
        case .like(_):
            break
        case .follow:
          // configure button
            break
        
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout subviews photo, text, phost button
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        
        let size = contentView.height-4
        followButton.frame = CGRect(x: contentView.width-5-size,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        label.frame = CGRect(x: profileImageView.rigth+5,
                             y: 0,
                             width: contentView.width-size-profileImageView.width-16,
                             height: contentView.height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
