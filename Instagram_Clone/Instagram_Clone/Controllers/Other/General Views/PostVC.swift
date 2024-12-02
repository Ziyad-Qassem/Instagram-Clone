//
//  PostVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit

 class PostVC: UIViewController {
    private var myPost: UserPost?
     private let model = PostViewViewModel()
    private let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
     }()
     
     init(myPost: UserPost?) {
         super.init(nibName: nil, bundle: nil)
         self.myPost = myPost
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .systemBackground
         view.addSubview(tableView)
         
         tableView.delegate = self
         tableView.dataSource = self
         
         tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
         tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
         tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
         tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
         
         
        // Do any additional setup after loading the view.
    }
     override func viewDidLayoutSubviews() {
         tableView.frame = view.bounds
     }

    

}
// MARK: - confirming tableview protocols
extension PostVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}




