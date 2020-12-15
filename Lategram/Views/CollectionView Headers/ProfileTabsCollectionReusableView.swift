//
//  ProfileTabsCollectionReusableView.swift
//  Lategram
//
//  Created by Daval Cato on 12/12/20.
//

import UIKit

// Adding action to the buttons to relay the event to the viewcontroller
protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    // This controls the size the padding 
    struct Constants {
        static let padding: CGFloat = 4
}
    
    // Two buttons 1 for the tags and the 2 button for the grid
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        
        return button
        
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        
        return button
        
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        // Adding the two buttons to the views
        addSubview(taggedButton)
        addSubview(gridButton)
        
        // Action is added here
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapGridButton() {
        delegate?.didTapGridButtonTab()
        
    }
    
    @objc private func didTapTaggedButton() {
        delegate?.didTapTaggedButtonTab()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Laying subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding * 2)
        let gridButtonX = ((width/2)-size)/2
        
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constants.padding,
                                    width: size,
                                    height: size)
        
        taggedButton.frame = CGRect(x: gridButtonX + (width/2),
                                    y: Constants.padding,
                                    width: size,
                                    height: size)
        
    }
 
}
