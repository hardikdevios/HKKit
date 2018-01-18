//
//  HKConstant.swift
//  HKCustomization
//
//  Created by Hardik on 11/13/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation
import UIKit
open class HKConstant:NSObject {
    struct Singleton {
        static let sharedInstance = HKConstant()

    }
    public class var sharedInstance: HKConstant {
        return Singleton.sharedInstance
    }
    public var main_color:UIColor = UIColor.black
    public var main_logo:String!
    public var main_url:String = ""
    
}


//}
