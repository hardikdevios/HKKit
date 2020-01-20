//
//  HKViewPager.swift
//  Genemedics
//
//  Created by Praxinfo on 6/30/16.
//  Copyright © 2016 Praxinfo. All rights reserved.
//

import Foundation
import UIKit
#if canImport(Cartography)
import Cartography

open class HKViewPager: HKCardView {

    public let indicator = UIView()
    open var group: ConstraintGroup!
    open var leading: NSLayoutConstraint!

    open var onSelected: ((ViewPager) -> Void)?
    open var isUpperCase: Bool = false

    open var font =  UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
    open var indicatorColor = HKConstant.sharedInstance.main_color
    let stackView:UIStackView = {
        
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 1
        stackview.distribution = .fillEqually
        stackview.alignment = .fill
        return stackview
    } ()

    public var distribution:UIStackView.Distribution = .fillEqually {
        
        didSet{
            self.stackView.distribution = self.distribution
            self.cleanUp()
        }
    }

    fileprivate var selectedView: TabView?
    fileprivate var allviews = [TabView]()

    open var data: [ViewPager]! {
        didSet {
            self.cleanUp()
        }

    }

    convenience init() {
        self.init(frame:.zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    func cleanUp() {
        allviews.forEach({$0.removeFromSuperview()})
        allviews.removeAll()
        selectedView = nil
        
        self.setUp()
        self.constraintSetup()
        self.setupLeftrightSeprator()
        

    }

    func constraintSetup() {

        group = constrain(indicator, self.selectedView!) { (indicator, view) in

            indicator.width == view.width
            indicator.height == 3
            indicator.bottom == indicator.superview!.bottom
            indicator.centerX == view.centerX

        }
        
        constrain(stackView) { (view) in
            view.width == view.superview!.width
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom - 3
            view.centerX == view.superview!.centerX
        }

    }

    func setUp() {

        indicator.backgroundColor = indicatorColor
        addSubview(indicator)
        addSubview(stackView)
        
        backgroundColor = .white
        for obj in data.enumerated() {

            let view = TabView(object: obj.element, font:font)
            view.isUpperCase = isUpperCase
            view.clouser = { goalview in

                self.updateSelection(goalview.object)

                UIView.animate(withDuration: 0.3, animations: {
                    self.layoutIfNeeded()

                    }, completion: { (_) in
                        self.onSelected?(goalview.object)

                })
            }
            stackView.addArrangedSubview(view)

            allviews.append(view)

        }

        self.selectedView = allviews[0]
        self.selectedView?.selected = true

    }

    func setupLeftrightSeprator(){
        
        
        if self.distribution == .fillProportionally {
            let leftSepView = UIView()
            stackView.insertArrangedSubview(leftSepView, at: 0)
            
            let rightSepView = UIView()
            stackView.insertArrangedSubview(rightSepView, at: stackView.subviews.count)
            
            constrain(leftSepView, rightSepView) { (left, right) in
                left.width == 2
                right.width == 2
            }

        }
       

        
        
    }

    open func updateSelection(_ object: ViewPager) {

        self.selectedView?.selected = false
        self.selectedView = allviews.filter({$0.object.title == object.title}).first
        self.selectedView?.selected = true
        self.group = constrain(self.indicator, self.selectedView!, replace: self.group) { (indicator, view) in

            indicator.width == view.width
            indicator.height == 3
            indicator.bottom == indicator.superview!.bottom
            indicator.centerX == view.centerX
        }

    }

}

private class TabView: UIView {

        let lbl = UILabel()
        var object: ViewPager!
        var font: UIFont!
        var isUpperCase: Bool = false {

            didSet {

                self.lbl.text = self.object.title.uppercased()
            }
        }
        var selected: Bool = false {
            didSet {

                if selected {

                    lbl.textColor = HKConstant.sharedInstance.main_color
                    lbl.font = UIFont.systemFont(ofSize: self.font.pointSize, weight: UIFont.Weight.bold)

                } else {
                    lbl.textColor = .black
                    lbl.font = UIFont.systemFont(ofSize: self.font.pointSize, weight: UIFont.Weight.regular)

                }
            }

        }

        var clouser: ((TabView) -> Void)?

        convenience init(object: ViewPager, font: UIFont) {
            self.init(frame:CGRect.zero)
            self.object = object
            self.font = font
            setup()

        }
        override init(frame: CGRect) {
            super.init(frame:frame)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setup() {

            lbl.text =  self.object.title
            lbl.font = self.font
            lbl.textAlignment = .center
            addSubview(lbl)
            constrain(lbl, block: { (lbl) in

                let view = lbl.superview!

                lbl.top == view.top
                lbl.bottom == view.bottom
                lbl.leading == view.leading + 1
                lbl.trailing == view.trailing - 1

            })

            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.click(_:)))
            self.addGestureRecognizer(gesture)

        }

        @objc func click(_ gesture: UITapGestureRecognizer) {

            clouser?(gesture.view as! TabView)

        }

}
#endif
