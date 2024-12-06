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
         tableView.register(IGFeedPostCommentsTableViewCell.self, forCellReuseIdentifier: IGFeedPostCommentsTableViewCell.identifier)
         
         
        // Do any additional setup after loading the view.
    }
     override func viewDidLayoutSubviews() {
         tableView.frame = view.bounds
     }

    

}
// MARK: - confirming tableview protocols
extension PostVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // so here we give each section of header , actions , postContent a one raw and give the comment section a number of raws base on the number of comments the post got
        if (section == 3){
            return (myPost?.comments.count)! > 4 ? 4 : (myPost?.comments.count)!
        }
        else {
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // sections number 0 - 3 for header , post content , actions , comments
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier , for: indexPath) as! IGFeedPostHeaderTableViewCell
            
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier , for: indexPath) as! IGFeedPostTableViewCell
            
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            
            
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostCommentsTableViewCell.identifier, for: indexPath) as! IGFeedPostCommentsTableViewCell
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
            return 70
            case 1:
            return tableView.viewWidth
            case 2:
            return 60
        default:
            return 50
        }
    }
}




