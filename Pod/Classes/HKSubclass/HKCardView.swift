//
//  HKCardView.swift
//  Genemedics
//
//  Created by Hardik shah on 21/11/15.
//  Copyright © 2015 Plenar. All rights reserved.
//

import UIKit

open class HKCardView: UIView {

    open var radius: CGFloat = 2
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0);
        layer.shadowOpacity = 0.1
        layer.shadowPath = shadowPath.cgPath
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
