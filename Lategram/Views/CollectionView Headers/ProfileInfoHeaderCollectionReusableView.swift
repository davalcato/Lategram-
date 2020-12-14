//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Lategram
//
//  Created by Daval Cato on 12/12/20.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
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
        return button
    
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        return button
    
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        return button
    
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        return button
    
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        return label
    
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Adding the subviews to the initizer
        addSubviews()
        backgroundColor = .systemBlue
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
        let countButtonWidth = width-10-profilePhotoSize
        
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
        
   }

}
