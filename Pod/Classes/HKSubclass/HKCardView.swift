//
//  HKCardView.swift
//  Genemedics
//
//  Created by Hardik shah on 21/11/15.
//  Copyright © 2015 Plenar. All rights reserved.
//

import UIKit

open class HKCardView: UIView {

    open var radius: CGFloat = 3
    open var shadowOpacity: Float = 0.3
    open var shadowRadius: CGFloat = 3.0
    open var isShadowVisible:Bool = true
    open var shadowColor: UIColor = UIColor.black
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if isShadowVisible {
            layer.cornerRadius = radius
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
            
            layer.masksToBounds = false
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0);
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
            layer.shadowPath = shadowPath.cgPath
        }
       
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
