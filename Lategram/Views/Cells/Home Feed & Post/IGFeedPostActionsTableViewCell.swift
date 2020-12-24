//
//  IGFeedPostActionsTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/10/20.
//

import UIKit

// Attaching the three buttons to a delegate

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}


class IGFeedPostActionsTableViewCell: UITableViewCell {
    
    // Creating instants of the IGFeedPostActionsTableViewCellDelegate on the class
    weak var delegate: IGFeedPostActionsTableViewCellDelegate?
    
    
    static let identifier = "IGFeedPostActionsTableViewCell"
    
    // Add three buttons here
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    // This button is for direct messages
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Adding the three buttons (likeButton, commentButton, sendButton) to the contentView
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        // Attach an action to the three buttons
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adding action to the three buttons
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton() {
        delegate?.didTapSendButton()
    }
    
    // Change to configure with post because of the three buttons
    public func configure(with post: UserPost) {
        // configure the cell...
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // like, comment , send
        let buttonSize = contentView.height-10
        
        // Laying out the buttons in a four loop
        let buttons = [likeButton, commentButton, sendButton]
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: (CGFloat(x)*buttonSize) + (10*CGFloat(x+1)), y: 5, width: buttonSize, height: buttonSize)
            
        }
        
    }

    // Adding the prepareForReuse to the Post Options button
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }

}
