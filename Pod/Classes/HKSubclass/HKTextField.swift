//
//  HKTextField.swift
//  Doctodoor
//
//  Created by Hardik on 19/09/15.
//  Copyright (c) 2015 PRAXINFO. All rights reserved.
//

import UIKit

class HKTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 5);
    override func awakeFromNib() {
        self.keyboardAppearance = .Default
    }
    

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
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
