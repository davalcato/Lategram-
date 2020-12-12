//
//  FormTableViewCell.swift
//  Lategram
//
//  Created by Daval Cato on 12/12/20.
//

import UIKit

// AnyObject so we can put a property on delegate: FormTableViewCellDelegate
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell( _ cell: FormTableViewCellDelegate, didUpdateField value: String?)

}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate, FormTableViewCellDelegate {
    func formTableViewCell( _ cell: FormTableViewCellDelegate, didUpdateField value: String?) {
        
        
    }

    
    static let identifier = "FormTableViewCell"
    
    // Property of the AnyObject & weak var so not to cause a memory leak
    public weak var delegate: FormTableViewCellDelegate?
    
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
        selectionStyle = .none
        
        
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
    
    
    // MARK: - Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.formTableViewCell(self, didUpdateField: textField.text)
        textField.resignFirstResponder()
        return true
    }
    
}
