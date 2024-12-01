//
//  FollowersListTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 29/10/2024.
//

import UIKit
import Kingfisher

protocol FollowersListTableViewCellDelegate: AnyObject {
    func listDidTapFollowButton(for model: FollowingListModel)
}

class FollowersListTableViewCell: UITableViewCell {
    
    private var model : FollowingListModel?
    
    public weak var  delegate : FollowersListTableViewCellDelegate?
    
    static let indentifier = "FollowersListTableViewCell"
    
    private let profileImage : UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
       
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let usertagLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        userNameLabel.text = ""
        usertagLabel.text = ""
        profileImage.image = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        
        CustomAddSubViews(profileImage , userNameLabel , usertagLabel , followButton)
        
        followButton.addTarget(self, action: #selector(didTapFellowButton), for: .touchUpInside)
        
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    private func configureSubviews(){
    
        let buttonWidth = contentView.viewWidth > 500 ? 220.0 : contentView.viewWidth / 3
      
        profileImage.frame = CGRect(x: 3, y: 3, width: contentView.viewHeight - 6, height: contentView.viewHeight - 6).integral
        
        profileImage.layer.cornerRadius =  profileImage.viewHeight / 2.0
        

        userNameLabel.frame = CGRect(x: profileImage.viewRight + 5, y: 0, width: viewWidth - 8 - profileImage.viewWidth , height: viewHeight / 2 ).integral
       
      
      
        usertagLabel.frame = CGRect(x: profileImage.viewRight + 5, y: userNameLabel.viewBottom, width: viewWidth - 8 - profileImage.viewWidth , height: viewHeight / 2).integral
        
        followButton.frame = CGRect(x:viewWidth - 5 - buttonWidth , y: (viewHeight - 40) / 2, width: buttonWidth, height:  40).integral
        
        followButton.layer.cornerRadius = followButton.frame.height / 2.0
        
    }
    
    @objc func didTapFellowButton(){
        guard let model = model else{
            return 
        }
        delegate?.listDidTapFollowButton(for: model)
    }
    
    func configureModel (model : FollowingListModel) {
        self.model = model
        DispatchQueue.main.async {
            self.profileImage.kf.setImage(with: model.imageUrl)
            self.usertagLabel.text = model.userTag
            self.userNameLabel.text = model.userName
            switch model.typeOfFollow {
            case .following:
                self.followButton.setTitle("Unfollow", for: .normal)
                self.followButton.setTitleColor(.white  , for: .normal)
                self.followButton.backgroundColor = .systemGray
            case .not_Flollowing:
                self.followButton.setTitle("Follow", for: .normal)
                self.followButton.setTitleColor(.white  , for: .normal)
                self.followButton.backgroundColor = .blue
            }
           
        }
    }
}
