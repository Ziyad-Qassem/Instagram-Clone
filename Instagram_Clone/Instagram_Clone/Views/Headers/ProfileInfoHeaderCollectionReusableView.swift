//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 25/10/2024.
//

import UIKit
import Kingfisher
protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header : ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header : ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header : ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header : ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapShareProfileButton(_ header : ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let indetifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate : ProfileInfoHeaderCollectionReusableViewDelegate?
  
    private let profileImage : UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .red
        image.layer.masksToBounds = true
        return image
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "User Name"
        return label
    }()
    
    private let shareButton : UIButton = {
       let button = UIButton()
        button.setTitle("Share Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
       return button
    }()
    
    private let postsButton : UIButton = {
       let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 2
        button.setTitle("100\nPost", for: .normal)
        return button
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "time to smash it"
        return label
    }()
    
    private let followingButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 2
        button.setTitle( "200\nFollowing", for: .normal)
        return button
    }()
    
    private let followersButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 2
        button.setTitle("205K\nFollowers", for: .normal)
        return button
    }()
    
    private let editProfileButton : UIButton = {
       let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Edit Your Profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
       
        CustomAddSubViews(profileImage , usernameLabel  , bioLabel ,postsButton , followingButton , followersButton , editProfileButton , shareButton )
        
        addButtonActions()
    }
    
    private func addButtonActions(){
        postsButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self,  action: #selector(didTapEditProfileButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
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
        let profileImageSize = viewWidth / 4
        
        profileImage.frame = CGRect(x: 5, y: 10, width: profileImageSize, height: profileImageSize + 10 ).integral
        profileImage.layer.cornerRadius = profileImageSize / 2.0
        
        let buttonWidth = (viewWidth - 10 - profileImageSize) / 3
        let buttonHeight = profileImageSize / 2
        let buttonYOffset = (profileImageSize) / 2.0
        postsButton.frame = CGRect(x: Int(profileImage.viewRight + 5), y: Int(buttonYOffset), width: Int(buttonWidth), height: Int(buttonHeight)).integral
        
        followersButton.frame = CGRect(x: postsButton.viewRight, y: buttonYOffset, width:buttonWidth , height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.viewRight, y: buttonYOffset, width: buttonWidth, height: buttonHeight).integral
        
        usernameLabel.frame = CGRect(x: 5, y: profileImage.viewBottom + 5 , width: viewWidth, height: 25).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        
        bioLabel.frame = CGRect(x: 5, y: usernameLabel.viewBottom, width: viewWidth, height: bioLabelSize.height)
        
        editProfileButton.frame = CGRect(x: 5, y: bioLabel.viewBottom , width: viewWidth / 2 , height: buttonHeight).integral
        
        shareButton.frame = CGRect(x: editProfileButton.viewRight, y: bioLabel.viewBottom, width: (viewWidth / 2) - 10, height: buttonHeight)
        
       
        }
    
    public func configureHeaderData(with imageURL : String ,  postNumber : String , followers : String , userFellowing : String  , userName : String , bio : String){
        
        profileImage.kf.setImage(with: URL(string: imageURL))
        
        postsButton.setTitle(postNumber, for: .normal)
        
        followersButton.setTitle(followers, for: .normal)
        
        followingButton.setTitle(userFellowing, for: .normal)
        
        usernameLabel.text = userName
        
        bioLabel.text = bio
        
   
    }
        
}
// MARK: - add buttons actions
extension ProfileInfoHeaderCollectionReusableView {
    @objc func didTapPostButton(){
        delegate?.profileHeaderDidTapPostButton(self)
    }
    @objc func didTapFollowersButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc func didTapFollowingButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    @objc func didTapShareButton(){
        delegate?.profileHeaderDidTapShareProfileButton(self)
    }
}
