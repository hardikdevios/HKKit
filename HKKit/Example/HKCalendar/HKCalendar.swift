//
//  HKCalendar.swift
//  HKKit
//
//  Created by Hardik Shah on 12/09/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import HKKit
import UIKit
import Cartography

open class HKCalendarController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    fileprivate func setUp() {
        
        view.backgroundColor = .white
        pageController.dataSource = self
        pageController.delegate = self
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        
        constrain(pageController.view) { (view) in
            
            view.edges == view.superview!.edges
            
        }
        pageController.didMove(toParentViewController: self)
        
        self.updateWithDay(animated:true)
    }

    
    
}
