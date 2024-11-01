//
//  NotificatioinsLikeEventTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 01/11/2024.
//

import UIKit
protocol NotificatioinsLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(Model: NotificationsModel)
}
class NotificatioinsLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificatioinsLikeEventTableViewCell"
    private var model :  NotificationsModel?
    
    private weak var delegate : NotificatioinsLikeEventTableViewCellDelegate?
    
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
    
    
    private let postButton : UIButton = {
        let button  = UIButton()

        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        
        CustomAddSubViews(profileImage , messageLabel , postButton)
        
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    
    @objc private func didTapPostButton(){
        guard let model = model else {return}
        delegate?.didTapRelatedPostButton(Model: model)
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
        
    }
    
    func configure(with profilePictureURL :  URL ,  message : String  , model : NotificationsModel){
        profileImage.kf.setImage(with: profilePictureURL)
        
        messageLabel.text = message
        
        self.model = model
    }

}
