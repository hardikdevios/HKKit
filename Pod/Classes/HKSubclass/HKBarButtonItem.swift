//
//  HKBarButtonItem.swift
//  HKKit
//
//  Created by Hardik Shah on 24/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit

open class HKBarButtonItem: UIBarButtonItem {
    
    public var onClick:((HKBarButtonItem)->())?
    override public init() {
        super.init()
        setup()
    }
    required public init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public convenience init(systemItem: UIBarButtonSystemItem) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        setup()

    }
    public convenience init(title: String,style: UIBarButtonItemStyle = .done) {
        self.init(title: title, style: style, target: nil, action: nil)
        setup()
        
    }
    
    public convenience init(image: UIImage,style: UIBarButtonItemStyle = .done) {
        self.init(image: image, style: style, target: nil, action: nil)
        setup()
        
    }
    func setup(){
        
        target = self
        action = #selector(self.buttonPressed)

    }
    
    @objc func buttonPressed()  {
        self.onClick?(self)
    }
}
