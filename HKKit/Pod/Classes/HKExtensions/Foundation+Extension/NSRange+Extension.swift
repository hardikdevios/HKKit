//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.startIndex.advancedBy(location)
        let endIndex = startIndex.advancedBy(length)
        return startIndex..<endIndex
    }
}
