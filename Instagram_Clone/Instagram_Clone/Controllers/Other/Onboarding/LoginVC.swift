//
//  LoginVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit

class LoginVC: UIViewController {
     
    private let userEmailField : UITextField = {
        return UITextField()
    }()
    private let userPasswordField : UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton : UIButton = {
        return UIButton()
    }()
    
    private let headerView : UIView  = {
       return UIView()
    }()
     
    private let privacyButton : UIButton = {
       return UIButton()
    }()
    
    private let termsButton : UIButton = {
       return UIButton()
    }()
    
    private let createAccountButton : UIButton = {
        return UIButton()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // this is a custom function created in the extenision
        view.addSubViews(userEmailField , userPasswordField , loginButton, privacyButton , createAccountButton , termsButton , headerView)
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    @objc func didTapLoginButton () {
        
    }
    
    @objc func didTapTermsButton () {
        
    }
    
    @objc func didTapPrivacyButton () {
        
    }
    
    @objc func didTapCreateAccountButton () {
        
    }
    
}
