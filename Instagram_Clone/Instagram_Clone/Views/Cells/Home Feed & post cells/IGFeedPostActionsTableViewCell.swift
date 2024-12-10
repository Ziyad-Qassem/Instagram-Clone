//
//  IGFeedPostActionsTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate {
    func didTapLikeButton()
    func didTapCommentsButton()
    func didTapShareButton()
    func didTapSaveButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostActionsTableViewCell"
      
    var delegate : IGFeedPostActionsTableViewCellDelegate?
        
    private let likeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        return button
    }()
    
    private let commentsButtons : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "message"), for: .normal)
        return button
    }()
    
    private let sharebutton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "parperplane"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    
    private let saveButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        return button
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        CustomAddSubViews(likeButton , commentsButtons , sharebutton , saveButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        
        commentsButtons.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        
        sharebutton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setSubviewLayout()
    }
    
    private func setSubviewLayout() {
        let size = contentView.viewHeight - 10
        
        likeButton.frame = CGRect(x: 3, y: 0, width: size , height: viewHeight - 10)
        
        commentsButtons.frame = CGRect(x: likeButton.viewRight + 5 , y: 0, width: size, height: size)
        
        sharebutton.frame = CGRect(x: commentsButtons.viewRight + 5, y: 0, width: size, height: size)
        
        saveButton.frame = CGRect(x: viewWidth - size, y: 0, width: size, height: size)
        
    }
    
    func configureCell(isLiked : Bool , isSaved : Bool){
        
    }
    
}

//MARK: - add action to button targets
extension IGFeedPostActionsTableViewCell {
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentsButton()
    }
    
    @objc private func didTapShareButton() {
        delegate?.didTapShareButton()
    }
    
    @objc private func didTapSaveButton() {
        delegate?.didTapSaveButton()
    }
}
