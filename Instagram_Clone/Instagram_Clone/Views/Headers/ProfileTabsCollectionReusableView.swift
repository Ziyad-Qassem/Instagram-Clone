//
//  ProfileTabsCollectionReusableView.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 25/10/2024.
//

import UIKit
protocol ProfileTabsCollectionReusableViewDelegate : AnyObject {
    func profileDidTapPostsButton(_ tap : ProfileTabsCollectionReusableView)
    func profileDidTapTaggedPostsButton(_ tap : ProfileTabsCollectionReusableView)
    func profileDidTapVideoPostsButton(_ tap : ProfileTabsCollectionReusableView)
}
final class ProfileTabsCollectionReusableView: UICollectionReusableView {
   static  let identifier = "ProfileTabsCollectionReusableView"
    public weak var delegate  : ProfileTabsCollectionReusableViewDelegate?
  
    private let taggedPostsButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "taggedPosts"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let videoPostsButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "video"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let gridButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "profilePosts"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        CustomAddSubViews(gridButton , videoPostsButton , taggedPostsButton)
        
        addButtonActions()
    }
    
    private func addButtonActions(){
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedPostsButton.addTarget(self, action: #selector(didTapTaggedPostsButton), for: .touchUpInside)
        videoPostsButton.addTarget(self, action: #selector(didTapVideoPostsButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
       configureSubviews()
    }
    
    private func configureSubviews(){
        let buttonWidth = viewWidth / 3.0
        
        gridButton.frame = CGRect(x: 5, y: 5, width: buttonWidth, height: 30)
        
        videoPostsButton.frame = CGRect(x: gridButton.viewRight, y: 5, width: buttonWidth, height: 30)
        
        taggedPostsButton.frame = CGRect(x: videoPostsButton.viewRight, y: 5, width: buttonWidth, height: 30)
    }
}
// MARK: - add actios to buttons
extension ProfileTabsCollectionReusableView {
    @objc func didTapGridButton() {
        
        gridButton.tintColor = .systemBlue
        taggedPostsButton.tintColor = .systemGray
        videoPostsButton.tintColor = .systemGray
        
        delegate?.profileDidTapPostsButton(self)
    }
    @objc func didTapTaggedPostsButton() {
       
        gridButton.tintColor = .systemGray
        taggedPostsButton.tintColor = .systemBlue
        videoPostsButton.tintColor = .systemGray
        
        delegate?.profileDidTapTaggedPostsButton(self)
    }
    @objc func didTapVideoPostsButton() {
        
        gridButton.tintColor = .systemGray
        taggedPostsButton.tintColor = .systemGray
        videoPostsButton.tintColor = .systemBlue
        
        delegate?.profileDidTapVideoPostsButton(self)
    }
}

