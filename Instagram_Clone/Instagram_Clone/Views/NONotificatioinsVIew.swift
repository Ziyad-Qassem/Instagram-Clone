//
//  NotificatioinsVIew.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 01/11/2024.
//

import UIKit
class NoNotificatioinsVIew: UIView {
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "No notifications Yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let bellImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName:"bell")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CustomAddSubViews(label , bellImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bellImageView.frame = CGRect(x: (viewWidth - 50) / 2, y: 0, width: 50 , height: 50).integral
        label.frame = CGRect(x: 0, y: bellImageView.viewBottom , width: viewWidth, height: viewHeight - 50 ).integral
        
    }
    
}
