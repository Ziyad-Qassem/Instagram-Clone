//
//  ViewController.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var viewModel : HomeViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
         
        // check Auth status
        isUserSignedIn()
    }

    private func isUserSignedIn () {
        guard let signInStatus = viewModel?.checkUserAuthenticatinStatus() else {
            return
        }
        print("********************")
        print("\(signInStatus)")
        print("********************")
        
        if signInStatus  {
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc , animated:  true)
        }
        
    
    }
    
}

