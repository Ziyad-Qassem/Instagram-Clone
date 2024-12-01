//
//  UIViewControllerExtenisoin.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import Foundation
import UIKit
extension UIView {
   public var viewWidth : CGFloat  {
        return frame.size.width
    }
    public var viewHeight : CGFloat {
        return frame.size.height
    }
    public var viewLeft : CGFloat {
        return frame.origin.x
    }
    
    public  var viewRight : CGFloat {
        return viewLeft + frame.size.width
    }
    
    public var viewTop : CGFloat {
        return frame.origin.y
    }
    
    public var viewBottom : CGFloat {
        return viewTop + frame.size.height
    }
    
   
    
    func CustomAddSubViews (_ views : UIView...) {
        
        views.forEach{self.addSubview($0)}
        
    }
    
    
    
}
