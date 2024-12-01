//
//  RegistrationVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit

class RegistrationVC: UIViewController {
    var viewModel  = RegistrationViewModel()
    
    private let headerView : UIView = {
       let header = UIView()
        header.clipsToBounds = true
        return header
    }()
    private let userNameTextField : UITextField = {
       let textField = CustomUITextField()
        textField.placeholder = "Username"
        return textField
    }()
    
    private let userEmailTextField : UITextField = {
        let textField = CustomUITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private let userPasswordTextField : UITextField = {
        let textField = CustomUITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let optionLabel : UILabel = {
       let label = UILabel()
        label.text = "Already have an account?"
        label.textColor = .black
        return label
    }()
    
    private let logInButton : UIButton = {
        let button = UIButton()
        button.setTitle("log in ", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
       
        view.CustomAddSubViews(headerView , userNameTextField , userEmailTextField , userPasswordTextField , createAccountButton , optionLabel , logInButton)
        
        userNameTextField.delegate = self
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        CreateSubViewsConstraints()
    }
    
    @objc func didTapCreateAccount () {
        
        userNameTextField.resignFirstResponder()
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
        viewModel.createUserInFirebase(userEmail: userEmailTextField.text, userPassword: userPasswordTextField.text, userName: userNameTextField.text) { registered in
            DispatchQueue.main.async {
                if registered{
                    let vc = HomeViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
                else {
                    let alert = UIAlertController(title: "Registration Error", message: self.viewModel.errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "dismiss", style: .cancel))
                    self.present(alert, animated: true)
                }

            }
        }
       
    }
    
    @objc func didTapLogInButton () {
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func CreateSubViewsConstraints() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.viewWidth, height: view.viewHeight / 3)
        
        createHeaderSubViews()
        
        userNameTextField.frame = CGRect(x: 25, y: headerView.viewBottom + 40, width: view.viewWidth - 50, height: 52)
        
        userEmailTextField.frame = CGRect(x: 25, y: userNameTextField.viewBottom + 15, width: view.viewWidth - 50, height: 52)
        
        userPasswordTextField.frame = CGRect(x: 25 , y: userEmailTextField.viewBottom + 15, width: view.viewWidth - 50 , height: 52)
        
        createAccountButton.frame = CGRect(x: 25, y: userPasswordTextField.viewBottom + 50, width: view.viewWidth - 50 , height: 52)
        
        optionLabel.frame = CGRect(x: 80, y: view.viewHeight - view.safeAreaInsets.bottom - 50 , width: view.viewWidth - 100, height: 52)
        
        logInButton.frame = CGRect(x: optionLabel.viewRight - 90 , y: optionLabel.frame.origin.y, width: 50, height: 52)
    }
    
    private func createHeaderSubViews() {
        let imageView = UIImageView(image: UIImage(named: "instragram_text"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.viewWidth / 4 , y: view.safeAreaInsets.top, width: headerView.viewWidth / 2 , height: headerView.viewHeight - view.safeAreaInsets.top)
        headerView.addSubview(imageView)

    }

}
// MARK: - textfield delegation

extension RegistrationVC: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userEmailTextField.becomeFirstResponder()
        }
        else if textField == userEmailTextField {
            userPasswordTextField.becomeFirstResponder()
        }
        else {
            didTapCreateAccount()
        }
        
        return true
    }
    
}

