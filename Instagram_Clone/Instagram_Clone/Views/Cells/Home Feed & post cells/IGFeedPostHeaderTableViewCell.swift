//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//

import UIKit

protocol PostMoreOptionsProtocol {
    func didTapMoreOptionsButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    private let profilePicture : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
     var delegate : PostMoreOptionsProtocol?
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Ziyad Qassem"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let optionsMenuButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ellipsis"), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        CustomAddSubViews(profilePicture , optionsMenuButton , userNameLabel)
        
        optionsMenuButton.addTarget(self, action: #selector(didTapMoretOptionsButton), for: .touchUpInside)
        
        
    }
    
    @objc private func didTapMoretOptionsButton(){
        delegate?.didTapMoreOptionsButton()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePicture.image = nil
        userNameLabel.text = nil
        userNameLabel.textColor = nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViewLayout()
    }
    
    private func configureViewLayout() {
        profilePicture.frame = CGRect(x: 3, y: 3, width: contentView.viewHeight - 6, height: contentView.viewHeight - 6).integral
        profilePicture.layer.cornerRadius = profilePicture.viewHeight / 2
        
        let size = contentView.viewHeight - 4
        
        userNameLabel.frame = CGRect(x: profilePicture.viewRight + 5, y: 0, width: size, height: size)
        
        optionsMenuButton.frame = CGRect(x: contentView.viewWidth - 5 - size, y: 0, width: size, height: size)
        
    }

}
