//
//  EditProfileVC.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import UIKit


final class EditProfileVC: UIViewController {
   
    
    private let viewModel = EditProfileViewModel()
    
    private var models = [[EditProfileFormModel]]()
    
    private let tableView : UITableView = {
        let tableview = UITableView()
        tableview.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.indentifier)
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancle", style: .plain, target: self, action: #selector(didTapCancle))
        view.addSubview(tableView)
        
        
        tableView.dataSource = self
        tableView.tableHeaderView = createHeaderView()
        configureTableViewCells()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func createHeaderView () -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.viewWidth, height: view.viewHeight / 4))
       
        let size = header.viewHeight / 1.5
        
        let profilePhotoButton  = UIButton(frame: CGRect(x: (header.viewWidth-size)/2, y: (header.viewHeight - size)/2, width: size, height: size))
        
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2.0
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.tintColor = .label
    
        header.addSubview(profilePhotoButton)
        
        return header
    }
    
    
    private func configureTableViewCells() {
        
        let  values : [String] = viewModel.configureModels()
        var num = 0
        // section one name , username , website , bio
        let sectionLabels = ["Name" , "Username" , "Bio"]
        var section1 : [EditProfileFormModel] = []
        for label in sectionLabels {
            
            let model = EditProfileFormModel(title: label, placeholder: values[num], value: nil)
            num = num + 1
            section1.append(model)
        }
        models.append(section1)
        // section two email , phone , gender
        
        var section2 : [EditProfileFormModel] = []
        let section2Labels = ["Email" , "Phone" , "Gender"]
        for label in section2Labels {
            let model = EditProfileFormModel(title: label, placeholder: values[num], value: nil)
            num = num + 1
            section2.append(model)
        }
        models.append(section2)
    }
}
//MARK: -  confirming the uitableview delegate and datasource protocol

extension EditProfileVC : UITableViewDataSource , FormViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdate model: EditProfileFormModel) {
        viewModel.whichModelIsChanged(changedModel: model)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.indentifier, for: indexPath) as! FormTableViewCell
        cell.configureCell(model: model)
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private information"
    }
   
}
// MARK: - buttons actions
extension EditProfileVC {
    
    @objc private func didTapSave() {
        // save info in database
        viewModel.updateDataBase()
        dismiss(animated: true)
    }
    @objc private func didTapCancle() {
        dismiss(animated: true )
    }
   
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        
            actionSheet.addAction(UIAlertAction(title: "take Photo ", style: .default, handler: { _ in}))
        
            actionSheet.addAction(UIAlertAction(title: "choose Photo from Library", style: .default, handler: { _ in}))
            
            actionSheet.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
            
            // for ipad not to crash
            actionSheet.popoverPresentationController?.sourceView = view
            actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
            present(actionSheet, animated: true)
    }
    
    @objc private func didTapProfilePhotoButton() {}
}

