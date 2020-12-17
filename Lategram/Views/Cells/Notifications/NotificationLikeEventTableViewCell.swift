//
//  NotificationLikeEventTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/16/20.
//

import SDWebImage
import UIKit


// The controllers handles the delegate here
protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    // When called we will retain the model
    private var model: UserNotification?
    
    // Add the subviews here...
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Joie liked your photo."
      
        return label
        
    }()
    
    // The follow button goes here...
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        
        
    }
    
    // Configure func to pass in a view model
    public func configure(with model: UserNotification) {
        // Retaining the model
        self.model = model
        
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                
                return
            }
            
            postButton.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
        case .follow:
            break
       
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
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
        postButton.frame = CGRect(x: contentView.width-size,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        label.frame = CGRect(x: profileImageView.rigth,
                             y: 0,
                             width: contentView.width-size-profileImageView.width-6,
                             height: contentView.height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
