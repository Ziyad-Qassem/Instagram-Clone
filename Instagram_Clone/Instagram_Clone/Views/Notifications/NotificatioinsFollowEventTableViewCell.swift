//
//  NotificatioinsFollowEventTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 01/11/2024.
//

import UIKit
import Kingfisher

protocol NotificatioinsFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowButton(Model: NotificationsModel)
}

class NotificatioinsFollowEventTableViewCell: UITableViewCell {

    static let identifier = "NotificatioinsFollowEventTableViewCell"
    private var model :  NotificationsModel?
    
    private weak var delegate : NotificatioinsFollowEventTableViewCellDelegate?
    
    private let profileImage : UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
       
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel : UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    
    private let FollowButton : UIButton = {
        let button  = UIButton()
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        
        CustomAddSubViews(profileImage , messageLabel , FollowButton)
        
        FollowButton.addTarget(self, action: #selector(didTapFellowButton), for: .touchUpInside)
    }
    
    @objc private func didTapFellowButton(){
        guard let model = model else {return}
        delegate?.didTapFollowButton(Model: model)
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
        FollowButton.setTitle("", for: .normal)
        FollowButton.backgroundColor = nil
        FollowButton.layer.borderWidth = 0
        
        messageLabel.text = ""
        
        profileImage.image  = nil
    }
    
    private func setSubViewsLayout(){
        
    }
    
    func configure(with profilePictureURL :  URL ,  message : String  , model : NotificationsModel){
        profileImage.kf.setImage(with: profilePictureURL)
        
        messageLabel.text = message
        
        self.model = model
    }
}
