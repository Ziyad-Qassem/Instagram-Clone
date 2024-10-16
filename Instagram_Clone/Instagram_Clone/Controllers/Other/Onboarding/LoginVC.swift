//
//  LoginVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit
import SafariServices
class LoginVC: UIViewController {
    
    let viewModel = LoginViewModel()
    
    private let userEmailField : UITextField = {
        // this is a custom class
        let field = CustomUITextField()
        field.placeholder = "Email or userName"
        
        return field
    }()
    
    private let userPasswordField : UITextField = {
        let field = CustomUITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        return field
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let headerView : UIView  = {
        
        let header = UIView()
        
        header.clipsToBounds = true
        
        let image = UIImageView(image: UIImage(named: "gradient"))
        
        header.addSubview(image)
        
        return header
    }()
     
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
       return button
    }()
    
    private let termsButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.setTitle("Terms of Services", for: .normal)
       return button
    }()
    
    private let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // this is a custom function created in the extenision
        view.CustomAddSubViews(userEmailField , userPasswordField , loginButton, privacyButton , createAccountButton , termsButton , headerView)
       
        view.backgroundColor = .systemBackground
        
        userEmailField.delegate = self
        
        userPasswordField.delegate = self
         
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createViewsFrames()
        
    }
    
    @objc func didTapLoginButton () {
        // login button tapped
        userPasswordField.resignFirstResponder()
        userEmailField.resignFirstResponder()
       
        viewModel.completionHandler  = {
            let alert = UIAlertController(title: "Error", message: self.viewModel.errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel))
            self.present(alert, animated: true)
        }
        
        viewModel.loginUser(email: userEmailField.text, password: userPasswordField.text, completion:   { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true)
                }
                else {
                    let alert = UIAlertController(title: "Log In error", message: self.viewModel.errorMessage, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    
                    self.present(alert, animated: true)
                }
            }
           
            
        })
        
    
        
    }
    
    @objc func didTapTermsButton () {
        //
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacyButton () {
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc , animated: true)
    }
    
    @objc func didTapCreateAccountButton () {
        
        let vc = RegistrationVC()
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
        
    }
    
    private func createViewsFrames () {
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.viewWidth, height: view.viewHeight / 3)
        
        createConstraintsForHeadViewSubViews()
   
        userEmailField.frame = CGRect(x: 25, y: headerView.viewBottom + 40, width: view.viewWidth - 50, height: 52)
        
        userPasswordField.frame = CGRect(x: 25, y: userEmailField.viewBottom + 10 , width: view.viewWidth - 50, height: 52)
        
        loginButton.frame = CGRect(x: 25, y: userPasswordField.viewBottom + 20, width: view.viewWidth - 50 , height: 60)
        
        createAccountButton.frame = CGRect(x: 25, y: loginButton.viewBottom + 10, width: view.viewWidth - 50 , height: 52)
        
        termsButton.frame = CGRect(x: 10 , y: Int(view.viewHeight-view.safeAreaInsets.bottom)-100 , width: Int(view.viewWidth) - 20, height: 50)
        
        privacyButton.frame = CGRect(x: 10, y: view.viewHeight - view.safeAreaInsets.bottom - 50, width: view.viewWidth - 20, height: 50)
        
        
        }
    
    private func createConstraintsForHeadViewSubViews () {
        
        guard let view = headerView.subviews.first else { return }
        
        view.frame = headerView.bounds
        
        let imageView = UIImageView(image: UIImage(named: "instragram_text"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.viewWidth / 4 , y: view.safeAreaInsets.top, width: headerView.viewWidth / 2 , height: headerView.viewHeight - view.safeAreaInsets.top)
        headerView.addSubview(imageView)
        
        
    }
  
}
// MARK: - extension

extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            userPasswordField.becomeFirstResponder()
        }
        else if textField == userPasswordField {
            didTapLoginButton()
        }
        
        
        return true
    }
}

