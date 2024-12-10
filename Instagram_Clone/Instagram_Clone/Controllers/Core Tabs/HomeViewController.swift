//
//  ViewController.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit
struct HomeFeedRenderViewModel {
    let header : postRenderViewModel
    let post : postRenderViewModel
    let actions : postRenderViewModel
    let comments : postRenderViewModel
}
struct  postRenderViewModel {
    let renderType : PostRenderType
}
enum PostRenderType {
    case header (provider : User)
    case primaryContent (provider: UserPost)
    case actions(provider : String)
    case comments(comments : [PostComments])
}
class HomeViewController: UIViewController {
    
    private var tableView : UITableView = {
       let tableView = UITableView()
        
        return tableView
    }()
    
    private  let feedRenderModels = [HomeFeedRenderViewModel]()
    
    
    
    private var viewModel : HomeViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.register(IGFeedPostContentTableViewCell.self, forCellReuseIdentifier: IGFeedPostContentTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostCommentsTableViewCell.self, forCellReuseIdentifier: IGFeedPostCommentsTableViewCell.identifier)
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
        feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model : HomeFeedRenderViewModel
        
        if section == 0 {
            model  = feedRenderModels[0]
        }
        else {
            let postion = section % 4 == 0 ? section % 4 : (section - (section%4) / 4)
            model = feedRenderModels[postion]
        }
        let postionInSection = section % 4
        if postionInSection == 0 {
            // this is the post's header
            return 1
        }else if postionInSection == 1 {
            // this is the post's content
            return 1
        }
        else if postionInSection == 2 {
            // this is the actions (like , share , comment) and the user caption
            return 1
        }else if postionInSection == 3 {
            // this is the comments's section
            let commentModel = model.comments
            switch commentModel.renderType {
           
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            @unknown default : fatalError("Invaild case")
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model : HomeFeedRenderViewModel
        
            if indexPath.section == 0 {
            model  = feedRenderModels[0]
            }
            else {
            let postion = indexPath.section % 4 == 0 ? indexPath.section % 4 : (indexPath.section - (indexPath.section%4) / 4)
            model = feedRenderModels[postion]
            }
        let postionInSection = indexPath.section % 4
            
            if postionInSection == 0 {
            // this is the post's header
            let headerModel = model.header
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostContentTableViewCell.identifier , for: indexPath) as! IGFeedPostContentTableViewCell
                
                return cell
            }else if postionInSection == 1 {
            // this is the post's content
            let postModel = model.post
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostContentTableViewCell.identifier , for: indexPath) as! IGFeedPostContentTableViewCell
                
                return cell
            }
            else if postionInSection == 2 {
            // this is the actions (like , share , comment) and the user caption
                let actions = model.actions
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostContentTableViewCell.identifier , for: indexPath) as! IGFeedPostContentTableViewCell
            
            return cell
            }else if postionInSection == 3 {
            // this is the comments's section
            let commentModel = model.comments
            switch commentModel.renderType {
           
                case .comments(let comments):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostContentTableViewCell.identifier , for: indexPath) as! IGFeedPostContentTableViewCell
                
                    return cell
                @unknown default : fatalError("Invaild case")
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostContentTableViewCell.identifier , for: indexPath) as! IGFeedPostContentTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            // header
           return 70
        case 1:
            // primary content
            return tableView.viewWidth
        case 2:
            // actions
            return 120
        default:
            // comments
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let positionInSection = section % 4
        return positionInSection == 3 ? 70 : 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
