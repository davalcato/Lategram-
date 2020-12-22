//
//  IGFeedPostTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/10/20.
//

import AVFoundation
import SDWebImage
import UIKit

// final so no one can subclass this....
/// Cell for primary post content to basically show a video or image view
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    // Create an imageView here
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        return imageView
        
    }()
    
    // Create video player here
    private var player: AVPlayer?
    
    // Player Layer
    private var playerLayer = AVPlayerLayer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        // Set up a player layer here
        contentView.layer.addSublayer(playerLayer)
        
        // Now add contentView as a subview
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        
        return
        // configure the cell...
        switch post.postType {
        case .photo:
            // Show image
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            // Load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Giving the PlayerLayer a frame here
        playerLayer.frame = contentView.bounds
        
        postImageView.frame = contentView.bounds
    }
    
    // Implement prepareForReuse here
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

}
