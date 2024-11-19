//
//  NotificatioinsLikeEventTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 01/11/2024.
//

import UIKit
protocol NotificatioinsLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: NotificationsModel)
}
class NotificatioinsLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificatioinsLikeEventTableViewCell"
    private var model :  NotificationsModel?
    
     weak var delegate : NotificatioinsLikeEventTableViewCellDelegate?
    
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
        label.numberOfLines = 0
        label.text = "@ziyad liked your photo"
        return label
    }()
    
    
    private let postButton : UIButton = {
        let button  = UIButton()
        button.setBackgroundImage(UIImage(named: "Tree Decor"), for: .normal)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        
        CustomAddSubViews(profileImage , messageLabel , postButton)
        
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        
        selectionStyle = .none
    }
    
    @objc private func didTapPostButton(){
        guard let model = model else {return}
        delegate?.didTapRelatedPostButton(model: model)
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
        postButton.setBackgroundImage(nil ,for: .normal)
        
        messageLabel.text = nil
        
        profileImage.image  = nil
    }
    
    private func setSubViewsLayout(){
        profileImage.frame = CGRect(x: 3, y: 3, width: contentView.viewHeight - 6, height: contentView.viewHeight - 6)
        profileImage.layer.cornerRadius = contentView.viewHeight / 2
        
        let size = contentView.viewHeight - 4
        postButton.frame = CGRect(x: contentView.viewWidth - 5 - size , y: 2, width: size, height: size)
        
        messageLabel.frame = CGRect(x: profileImage.viewRight + 5, y: 0, width: contentView.viewWidth - size - profileImage.viewWidth - 16, height: contentView.viewHeight)
    }
    
    func configure(with model : NotificationsModel){
        switch model.notificationType {
            case .follow:
                break
            case .like(let post):
            postButton.imageView?.kf.setImage(with: post.thumpnailImageURL)
        }
        //profileImage.kf.setImage(with: model.followingUser.profilePicture)
        
        messageLabel.text = model.notificationMessage
        self.model = model
    }
    
    func configure2 (with data : String , image : UIImage){
        messageLabel.text = data
        profileImage.image = image
    }

}
