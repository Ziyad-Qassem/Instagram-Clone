//
//  ProfileTabsCollectionReusableView.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 25/10/2024.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
   static  let identifier = "ProfileTabsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
