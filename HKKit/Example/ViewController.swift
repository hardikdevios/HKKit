//
//  ViewController.swift
//  Example
//
//  Created by Hardik Shah on 24/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit
import HKKit
class ViewController: UIViewController {
    @IBOutlet var tableView:HKTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = HKBarButtonItem(systemItem: .add)
        button.onClick = { barbutton in
            
            print(barbutton)
        }
        self.navigationItem.rightBarButtonItem = button
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

