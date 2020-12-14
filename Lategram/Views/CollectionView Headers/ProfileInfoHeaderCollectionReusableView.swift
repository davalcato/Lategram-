//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Lategram
//
//  Created by Daval Cato on 12/12/20.
//

import UIKit

// Made it AnyObject so we can make it weak
protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    // we want four function here
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}


// Final so no one can subclass it
final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    // This is how we get the button interactions out
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    //  Seven subviews go here
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joie Chavez"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the only account!"
        label.textColor = .label
        label.numberOfLines = 0 // will line wrap
        return label
    
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButtonActions()
        // Adding the subviews to the initizer
        addSubviews()
        backgroundColor = .systemBackground
        clipsToBounds = true
        
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(followingButton)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
        
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton),
                                  for: .touchUpInside)
        
        followingButton.addTarget(self, action: #selector(didTapFolloweringButton),
                                  for: .touchUpInside)
        
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton),
                                  for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButtonButton),
                                  for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Laying out the subviews
        let profilePhotoSize = width/4
        
        // Integral rounds up all the numbers to nearest interger
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize).integral
        
        // Making the profilePhoto circular
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        postsButton.frame = CGRect(
            x: profilePhotoImageView.rigth,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral
        
        followersButton.frame = CGRect(
            x: postsButton.rigth,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral
        
        followingButton.frame = CGRect(
            x: followersButton.rigth,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(
            x: profilePhotoImageView.rigth,
            y: 5 + buttonHeight,
            width: countButtonWidth*3,
            height: buttonHeight).integral
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5 + profilePhotoImageView.bottom,
            width: width-10,
            height: 50).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        
        bioLabel.frame = CGRect(
            x: 5,
            y: 5 + nameLabel.bottom,
            width: width-10,
            height: bioLabelSize.height).integral
   }
    
    // MARK: - Actions
    
    // Using objc to expose it to the selectors
    @objc private func didTapFollowersButton() {
        // Leveraging the delegate to convey to the viewController what happen to stay in design pattern
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFolloweringButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
    @objc private func didTapPostsButtonButton() {
        delegate?.profileHeaderDidTapPostButton(self)
    }

}


