//
//  ViewController.swift
//  Example
//
//  Created by Hardik Shah on 24/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit
import HKKit
import AVFoundation


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let controller = self.childViewControllers.first as? HKCalendarController {
            
            
            controller.dateChangeHandler = { day in
                
                
                print(day.toString())
            }
            
        }
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

