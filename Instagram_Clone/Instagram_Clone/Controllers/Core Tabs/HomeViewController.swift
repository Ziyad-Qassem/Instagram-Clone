//
//  ViewController.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var tableView : UITableView = {
       let tableView = UITableView()
        
        return tableView
    }()
    
    
    
    private var viewModel : HomeViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
         
        // check Auth status
        isUserSignedIn()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
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

// MARK: - confirming uitableview delegate and datasource protocols

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier , for: indexPath) as! IGFeedPostTableViewCell
        
        return cell
    }
    
    
}
