//
//  FormTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 25/10/2024.
//

import UIKit

protocol FormViewCellDelegate  : AnyObject{
    func formTableViewCell (_ cell : FormTableViewCell , didUpdate model : EditProfileFormModel)
    }

class FormTableViewCell: UITableViewCell {
    private var model : EditProfileFormModel?
    public weak var delegate : FormViewCellDelegate?
    
    static let indentifier = "FormTableViewCell"
    
    private let formLabel : UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let formTextField : UITextField = {
        var field = UITextField()
        field.returnKeyType = .done
        field.autocapitalizationType = .none
        return  field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(formTextField)
        formTextField.delegate = self
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(model : EditProfileFormModel) {
        formLabel.text = model.title
        formTextField.placeholder = model.placeholder
        formTextField.text = model.value
        self.model = model
    }
    override func prepareForReuse() {
        super.prepareForReuse()
       
        formLabel.text = nil
        formTextField.placeholder = nil
        formTextField.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.viewWidth / 3 , height: contentView.viewHeight)
        
        formTextField.frame = CGRect(x: formLabel.viewRight + 5 , y: 0, width: contentView.viewWidth - 10 - formLabel.viewWidth, height: contentView.viewHeight)
    }
}
// MARK: - confirming UITextfield's  protocols
extension FormTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        model?.value = textField.text
        guard let model = model else {
            return
        }
        delegate?.formTableViewCell(self, didUpdate: model)
    }
}
