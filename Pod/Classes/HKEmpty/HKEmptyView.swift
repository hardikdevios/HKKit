//
//  HKEmptyView.swift
//  Genemedics
//
//  Created by Hardik on 10/10/16.
//  Copyright © 2016 Praxinfo. All rights reserved.
//

import UIKit

open class HKEmptyView: HKNibView {

    @IBOutlet public weak var lblTitle: UILabel!
    @IBOutlet public weak var imgMain: UIImageView!
    convenience init() {
        self.init(frame: CGRect.zero)
        self.setUp()

    }
    override public init(frame: CGRect) {
        super.init(frame: frame)

    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()

    }

    func setUp() {

        imgMain.hk_setAppTintColor()
    }

}
