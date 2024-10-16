//
//  CustomUITextField.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//


import UIKit
class CustomUITextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup( ) {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = Constants.cornerRadius
        self.backgroundColor = .secondarySystemBackground
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.returnKeyType = .next
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        
        
    }

}
