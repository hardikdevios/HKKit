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

protocol Groupable:Hashable
{
    var parent: Self? { get }
    var children: Set<Self> { get }
}
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
    override func viewWillAppear(_ animated: Bool) {
//        let dispatchTime = DispatchTime.now() + .seconds(3)
//        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
//            let vc = SecondViewController()
//            self.present(vc, animated: true, completion: nil)
//        }
    }
    
    func checkAuth(){
        
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized
        {
            // Already Authorized
        }
        else
        {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted :Bool) -> Void in
                if granted == true
                {
                    // User granted
                }
                else
                {
                    // User Rejected
                }
            });
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

