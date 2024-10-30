//
//  ListVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit

class ListVC: UIViewController {
    
    private let viewModel  = ListViewViewModel()

    private let tableView : UITableView  = {
        let tableView = UITableView()
        tableView.register(FollowersListTableViewCell.self, forCellReuseIdentifier: FollowersListTableViewCell.indentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}
// MARK: - confirming uitableview protocols
extension ListVC : UITableViewDelegate, UITableViewDataSource , FollowersListTableViewCellDelegate{
    func listDidTapFollowButton(for model: FollowingListModel) {
        // change follow button status
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUserFollowersList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowersListTableViewCell.indentifier, for: indexPath) as! FollowersListTableViewCell
        cell.delegate = self
        
        let model = FollowingListModel(userName: "Ziyad Qassem", userTag: "@ElZozo97", imageUrl: URL(string: "https://plus.unsplash.com/premium_photo-1669343628944-d0e2d053a5e8?q=80&w=2832&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!, typeOfFollow: .following)
       
            cell.configureModel(model: model)
        
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("did select")
        
        guard let model  = viewModel.getFollowInfoAtIndexPath(At: indexPath.row) else{
            return
        }
        
        let vc = ProfileVc()
        vc.username = model.userName
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}
