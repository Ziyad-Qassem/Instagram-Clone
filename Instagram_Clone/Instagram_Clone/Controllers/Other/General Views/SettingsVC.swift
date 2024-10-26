//
//  SettingsVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit
import SafariServices
final class SettingsVC: UIViewController {
    
    private let  viewModel  = SettingsViewModel()
    
    private let tableView : UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableview
    }()
    
    private var data = [[SettingsCellModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        
    }
    
    private func configureModels() {
        // section 0
        data.append([SettingsCellModel(title: "Edit profile") {[weak self] in
                                self?.didTapEditProfile()
            
                    },
                     SettingsCellModel(title: "Invite Friends") { [weak self] in
                                self?.didTapInviteFriends()
                    },
                     SettingsCellModel(title: "Save Original Posts") { [weak self] in
                                self?.didTapSaveOriginalPost()
                    }])
        
        // section 1
        data.append([SettingsCellModel(title: "Terms Of Service "){[weak self] in
                    self?.didTapLink(url: .terms, errorMessage: "Terms Of Service")
                    }])
        // section 2
        data.append( [SettingsCellModel(title: "Privacy Policy"){ [weak self] in
                    self?.didTapLink(url: .terms, errorMessage: "Privacy Policy")
                        }])
        // section 3
        data.append([SettingsCellModel(title: "Help / FeedBack ")  { [weak self] in
            self?.didTapLink(url: .terms, errorMessage: "Help Center")
        }])
        // section 4
     // adding log out section to table view
        data.append([
            SettingsCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()

            }
        ])
    }
    
   

}
// MARK: - applying tableview protocols

extension SettingsVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
            }
    
    
}
// MARK: - all buttons actions and cell selection actions

extension SettingsVC {
    private func didTapEditProfile() {
        let vc = EditProfileVC()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        }
    
    private func didTapInviteFriends() {
       // show share sheet to invite friends
        
    }
    
    private func didTapSaveOriginalPost(){

    }
    private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancle", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.viewModel.logout { success in
                DispatchQueue.main.async {
                    
                    if success {
                      
                        let vc = LoginVC()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex  = 0
                        }
                    }
                    else{
                        let alert = UIAlertController(title: "Log Out error", message: self.viewModel.errormessage, preferredStyle: .actionSheet)
                        self.present(alert, animated: true)
                        
                    }
                }
            }
        }))
      
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet , animated: true)
    }
            
    private func didTapLink(url : SettingsURL , errorMessage : String){
        viewModel.openURL(url: url) {  [weak self] url in
            guard let url = url else {
                let alert = UIAlertController(title: "Error", message: "Couldn't Open \(errorMessage)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "dismiss", style: .default))
                
                self?.present(alert, animated: true)
                
                return
            }
            let vc = SFSafariViewController(url: url)
            
            self?.present(vc, animated: true)
        }
    }
    
    
}
