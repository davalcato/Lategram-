//
//  FormTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/12/20.
//

import UIKit

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCell"
    
    // Two subview here...
    private let formlabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
        
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        // Adding subviews here
        contentView.addSubview(formlabel)
        contentView.addSubview(field)
        field.delegate = self
        
        
    }
    
    // MARK: - Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        formlabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
        
    }
    // Set the frames everytime the model is reused...
    override func prepareForReuse() {
        super.prepareForReuse()
        formlabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Assign frames here - layout the label & field
        formlabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        
        field.frame = CGRect(x: formlabel.rigth + 5,
                             y: 0,
                             width: contentView.width-10-formlabel.width,
                             height: contentView.height)
        
        
    }
    
}
