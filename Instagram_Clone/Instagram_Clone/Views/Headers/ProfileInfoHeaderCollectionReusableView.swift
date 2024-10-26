//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 25/10/2024.
//

import UIKit
import Kingfisher
class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let indetifier = "ProfileInfoHeaderCollectionReusableView"
    
    private let profileImage : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.systemPink.cgColor
        image.layer.borderWidth = 2
        image.layer.masksToBounds = false
        image.clipsToBounds = true
       
        return image
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let followersLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private let postNumberLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private let userFellowingLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(postNumberLabel)
        addSubview(followersLabel)
        addSubview(userFellowingLabel)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerSubViewsConfigure()
    }
   
    private func headerSubViewsConfigure() {
        // top part of the header
        profileImage.frame = CGRect(x: 0, y: 5, width: viewWidth / 3, height: viewHeight / 2)
      
        profileImage.layer.cornerRadius = profileImage.viewHeight / 2
        
        let width = viewWidth - profileImage.viewWidth
        
        postNumberLabel.frame = CGRect(x: Int(profileImage.viewRight) + 2, y: Int( profileImage.viewTop + profileImage.viewHeight - 10 ) / 2 , width: Int(width) / 3 , height: Int(viewHeight) / 4)
        
        followersLabel.frame = CGRect(x: Int(postNumberLabel.viewRight) + 2, y: Int(profileImage.viewBottom - profileImage.viewTop ) / 2, width: Int(width) / 3 , height: Int(viewHeight) / 4)
        
        userFellowingLabel.frame = CGRect(x: Int(followersLabel.viewRight) + 2, y: Int(profileImage.viewBottom - profileImage.viewTop ) / 2, width: Int(width) / 3 , height: Int(viewHeight) / 4)
        }
    
    public func configureHeaderData(with imageURL : String ,  postNumber : String , followers : String , userFellowing : String ){
        
        profileImage.kf.setImage(with: URL(string: imageURL))
        
        postNumberLabel.text = "\(postNumber)\n Posts"
        
        followersLabel.text = "\(followers)/n Fellowers"
        
        userFellowingLabel.text = "\(userFellowing)/n Following"
    }
        
}
