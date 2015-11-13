//
//  HKTextField.swift
//  Doctodoor
//
//  Created by Hardik on 19/09/15.
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit

public class HKTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 5);
    override public func awakeFromNib() {
        self.keyboardAppearance = .Default
    }
    

    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override public func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    private func newBounds(bounds: CGRect) -> CGRect {

        var newBounds = bounds
        newBounds.origin.x += padding.left + (self.leftView?.frame.size.width ?? 0)
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right + (self.leftView?.frame.size.width ?? 0)
        return newBounds
    }

    
   
}
