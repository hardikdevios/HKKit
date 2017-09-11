//
//  HKNibView.swift
//  Genemedics
//
//  Created by Praxinfo on 10/08/16.
//  Copyright © 2016 Praxinfo. All rights reserved.
//

import Foundation
import UIKit
import Cartography

open class HKNibView: UIView {

    weak var view: UIView!

    open var nibName: String? {
        return String(describing: type(of: self))
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    fileprivate func nibSetup() {

        view = loadViewFromNib()
        addSubview(view)

        constrain(view) { (view) in

            view.edges == inset(view.superview!.edges, 0, 0, 0, 0)
        }

    }

    fileprivate func loadViewFromNib() -> UIView {

        guard let nibName = nibName else {

            return UIView()
        }

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }

}
