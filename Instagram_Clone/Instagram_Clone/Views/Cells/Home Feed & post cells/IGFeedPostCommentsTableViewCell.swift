//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//

import UIKit

class IGFeedPostCommentsTableViewCell: UITableViewCell {
   
    static let identifier = "IGFeedPostCommentsTableViewCell"
     private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private let userNamelabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17 ,weight: .heavy)
        label.textColor = .black
        return label
    }()
    private let userProfilePicture : UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.CustomAddSubViews(userProfilePicture , userNamelabel , commentLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    override func prepareForReuse() {
        userProfilePicture.image  = nil
        userNamelabel.text = ""
        commentLabel.text = ""
    }
    
     private func configureSubviews(){
         userProfilePicture.frame = CGRect(x: 2, y: 2, width: 50 , height: contentView.viewHeight - 4)
         userProfilePicture.layer.cornerRadius = userProfilePicture.frame.height / 2
         userProfilePicture.clipsToBounds = true
         
        // userNamelabel.frame = CGRect(x: userProfilePicture.viewRight + 8, y: 2, width: <#T##Int#>, height: <#T##Int#>)
    }
}
