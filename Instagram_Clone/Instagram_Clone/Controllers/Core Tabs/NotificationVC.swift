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
       // spinner.startAnimating()
        view.addSubview(tableView)
       
        tableView.delegate = self
        tableView.dataSource = self
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
        0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getAllNotifications().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath)
        
        let model = viewModel.getAllNotifications()[indexPath.row]
        cell.imageView?.kf.setImage(with: model.userImageURL)
        cell.textLabel?.text = "\(model.notificationMessage).\(model.notificationDate)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // open the post you got the notification from
        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = PostVC(myPost: )
//        navigationController?.pushViewController(vc, animated: true)
    }
}
