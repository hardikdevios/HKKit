//
//  HKConstant.swift
//  HKCustomization
//
//  Created by Hardik on 11/13/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation
import UIKit
class HKConstant:NSObject {
    struct Singleton {
        static let sharedInstance = HKConstant()

    }
    class var sharedInstance: HKConstant {
        return Singleton.sharedInstance
    }
    
}
public var MAIN_COLOR:UIColor!
public var MAIN_LOGO:String!
public var MAIN_URL:String = ""

//}
