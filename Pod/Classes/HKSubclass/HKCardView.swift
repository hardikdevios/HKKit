//
//  HKCardView.swift
//  Genemedics
//
//  Created by Hardik shah on 21/11/15.
//  Copyright © 2015 Plenar. All rights reserved.
//

import UIKit

public class HKCardView: UIView {

    public var radius: CGFloat = 2
    
    override public func layoutSubviews() {
        layer.cornerRadius = radius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 3);
        layer.shadowOpacity = 0.3
        layer.shadowPath = shadowPath.CGPath
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
