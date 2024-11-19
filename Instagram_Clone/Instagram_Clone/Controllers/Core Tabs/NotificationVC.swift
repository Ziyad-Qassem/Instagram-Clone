//
//  NotificationVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit
import Kingfisher


class NotificationVC: UIViewController {
    
    private let viewModel = NotificationViewViewModel()
    private var tableView : UITableView = {
        let tabelView = UITableView(frame: .zero, style: .grouped)
        tabelView.register(NotificatioinsFollowEventTableViewCell.self, forCellReuseIdentifier: NotificatioinsFollowEventTableViewCell.identifier)
        tabelView.register(NotificatioinsLikeEventTableViewCell.self , forCellReuseIdentifier: NotificatioinsLikeEventTableViewCell.identifier)
        
        return tabelView
    }()
    
    private var testModels : [NotificationsModel] = []
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var  noNotificationView = NoNotificatioinsVIew()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
       spinner.startAnimating()
        view.addSubview(tableView)
       
        tableView.delegate = self
        tableView.dataSource = self
        
        let mockPost = UserPost(indentifier: "", postType: .photo, thumpnailImageURL: URL(string: "https://pin.it/5K8mgR5xz")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likes: [], comments: [], createdDate: Date(), taggedUsers: [])
        for x in 0...100 {
            let model = NotificationsModel(notificationMessage: "hello world"
                                           , followingUser: User(username: "Ziyad Qassem", name: (first : "Ziyad" , last : "Qassem"), birthDate:Date() , gender: .male, counts: UsersCounts(fellowers: 1, posts: 1, fellowing: 1), joinDate: Date(), profilePicture: URL(string: "https://pin.it/5K8mgR5xz")!),
                                           notificationDate: Date(),
                                           notificationType: x % 2 == 0 ? .like(post: mockPost) : .follow(state: .not_Flollowing))
            testModels.append(model)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    private func addNoNotificationsView(){
        tableView.isHidden = true
        view.addSubview(noNotificationView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: Int(view.viewWidth), height: Int(view.viewWidth) / 4)
        noNotificationView.center = view.center
    }

}


// MARK: - confirming uitableview delegate and datasource protocols

extension NotificationVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      viewModel.getAllNotifications().count
        testModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let model = viewModel.getAllNotifications()[indexPath.row]
//       
//        switch model.notificationType {
//            case .like:
//                let cell = tableView.dequeueReusableCell(withIdentifier: NotificatioinsLikeEventTableViewCell.identifier , for: indexPath) as! NotificatioinsLikeEventTableViewCell
//                    cell.delegate = self
//                cell.configure(with: model)
//                return cell
//            case .follow:
//                break
//                        }
//            let cell = tableView.dequeueReusableCell(withIdentifier: NotificatioinsFollowEventTableViewCell.identifier, for: indexPath) as! NotificatioinsFollowEventTableViewCell
//            cell.delegate = self
//            cell.configure(with: model)
//            return cell
        let model = testModels[indexPath.row]
            
                switch model.notificationType {
                    case .like:
                        let cell = tableView.dequeueReusableCell(withIdentifier: NotificatioinsLikeEventTableViewCell.identifier , for: indexPath) as! NotificatioinsLikeEventTableViewCell
                            cell.delegate = self
                        cell.configure(with: model)
                        return cell
                    case .follow:
                        let cell = tableView.dequeueReusableCell(withIdentifier: NotificatioinsFollowEventTableViewCell.identifier, for: indexPath) as! NotificatioinsFollowEventTableViewCell
                        cell.delegate = self
                        //cell.configure(with: model)
                    return cell
                        }
                   
                       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // open the post you got the notification from
        tableView.deselectRow(at: indexPath, animated: true)
        switch testModels[indexPath.row].notificationType {
            case .follow( _):
                break
        case .like(let post):
            let vc = PostVC(myPost: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc , animated: true)
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
}
// MARK: - confirming Custom cells protocols
extension NotificationVC  : NotificatioinsLikeEventTableViewCellDelegate , NotificatioinsFollowEventTableViewCellDelegate {
    
    func didTapRelatedPostButton(model: NotificationsModel) {
        // navigate to the post
        switch model.notificationType {
            case .like(let post):
                let vc = PostVC(myPost: post)
                vc.title = post.postType.rawValue
                vc.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(vc , animated: true)
            case .follow( _):
                break
            }
        
        
    }
    
    func didTapFollowButton(model: NotificationsModel) {
        // navigate to user profile
        let vc = ProfileVc()
        vc.navigationItem.title = model.followingUser.username
       
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
