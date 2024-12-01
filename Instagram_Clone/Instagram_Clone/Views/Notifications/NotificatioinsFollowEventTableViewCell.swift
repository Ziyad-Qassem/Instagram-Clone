//
//  NotificatioinsFollowEventTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 01/11/2024.
//

import UIKit
import Kingfisher

protocol NotificatioinsFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowButton(model: NotificationsModel)
}

class NotificatioinsFollowEventTableViewCell: UITableViewCell {

    static let identifier = "NotificatioinsFollowEventTableViewCell"
    private var model :  NotificationsModel?
    
     weak var delegate : NotificatioinsFollowEventTableViewCellDelegate?
    
    private let profileImage : UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel : UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.text = "@somebodyYouUsedTOKnow started following you."
        label.numberOfLines = 0
        return label
    }()
    
    
    private let followButton : UIButton = {
        let button  = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        
        CustomAddSubViews(profileImage , messageLabel , followButton)
        
        followButton.addTarget(self, action: #selector(didTapFellowButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapFellowButton(){
        guard let model = model else {return}
        delegate?.didTapFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setSubViewsLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle("", for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        
        messageLabel.text = ""
        
        profileImage.image  = nil
    }
    
    private func setSubViewsLayout(){
        profileImage.frame = CGRect(x: 3, y: 3, width: contentView.viewHeight - 6, height: contentView.viewHeight - 6)
        profileImage.layer.cornerRadius = contentView.viewHeight / 2
        
        let size : CGFloat = 100
        followButton.frame = CGRect(x: contentView.viewWidth - 5 - size , y: (contentView.viewHeight - 40) / 2 , width: size, height: 40)
        
        messageLabel.frame = CGRect(x: profileImage.viewRight + 5, y: 0, width: contentView.viewWidth - size - profileImage.viewWidth - 16, height: contentView.viewHeight)
    }
    
    func configure(with  model : NotificationsModel){
        profileImage.kf.setImage(with: model.followingUser.profilePicture)
        
        messageLabel.text = model.notificationMessage
        
        switch model.notificationType {
        case .follow(state: let state):
            switch state {
                case .following :
                followButton.setTitle("unfollow", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
                
                case .not_Flollowing:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
               

            }
        case .like(post: _) :
            break
        }
        self.model = model
    }
}
