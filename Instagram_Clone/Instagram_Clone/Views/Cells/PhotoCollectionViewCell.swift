//
//  PhotoCollectionViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 25/10/2024.
//

import UIKit
import Kingfisher
class PhotoCollectionViewCell: UICollectionViewCell {
     static let identifier = "PhotoCollectionViewCell"
    
    private let photoImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds =  true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double tap to open post"
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(with model : UserPost) {
        let url = model.thumpnailImageURL
        photoImageView.kf.setImage(with: url)
        
    }
    public func configurePhote (with imageName :  String){
        photoImageView.image = UIImage(named: imageName)
    }
}
