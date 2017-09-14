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
    @IBOutlet weak var tableView: UITableView!
    var arrData:[Plan_Day] = []
    var arrStrings = ["Pre-Workout Meal","Resistance Training", "Cardio Training", "Post-Workout Meal",
                   "Meal 1 (Breakfast)","Meal 2 (Snack)", "Meal 3 (Lunch)", "Meal 4 (Snack)", "Meal 5 (Dinner)", "Meal 6 (Snack)"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        
        if let controller = self.childViewControllers.first as? HKCalendarController {
            
            
            controller.dateChangeHandler = { day in
                
                
                self.fillData(startDate: day)
            }
            
        }
        fillData()
        
    }
    
    func fillData(startDate:Date = Date()){
        
        arrData.removeAll()
        
        for i in 0...23 {
            
            let obj = Plan_Day(time: startDate.adjust(hour: i, minute: 0, second: 0))

            if i == 5 {
                
                obj.data = [Plan_Data(plan_title: arrStrings[0], plan_time: startDate.adjust(hour: i, minute: 0, second: 0)),
                            Plan_Data(plan_title: arrStrings[1], plan_time: startDate.adjust(hour: i, minute: 20, second: 0))]
            }else if i == 6 {
                
                obj.data = [Plan_Data(plan_title: arrStrings[2], plan_time: startDate.adjust(hour: i, minute: 0, second: 0)),
                            Plan_Data(plan_title: arrStrings[3], plan_time: startDate.adjust(hour: i, minute: 0, second: 0))]

            }else if i == 8 {
                
                obj.data = [Plan_Data(plan_title: arrStrings[4], plan_time: startDate.adjust(hour: i, minute: 0, second: 0))]

                
            }else if i == 10 {
                
                obj.data = [Plan_Data(plan_title: arrStrings[5], plan_time: startDate.adjust(hour: i, minute: 0, second: 0))]
                
                
            }else if i == 13 {
                
                obj.data = [Plan_Data(plan_title: arrStrings[6], plan_time: startDate.adjust(hour: i, minute: 0, second: 0))]

            }else if i == 17 {
                
                obj.data = [Plan_Data(plan_title: arrStrings[7], plan_time: startDate.adjust(hour: i, minute: 0, second: 0))]
                
            }else if i ==  20 {
                obj.data = [Plan_Data(plan_title: arrStrings[8], plan_time: startDate.adjust(hour: i, minute: 0, second: 0))]

                
            }else if i ==  22 {
                obj.data = [Plan_Data(plan_title: arrStrings[9], plan_time: startDate.adjust(hour: i, minute: 0, second: 0))]
            }

            arrData.append(obj)

            
        }
        self.tableView.reloadData()
    }
    
    func getData(){
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableViewSetup(){
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.register(UINib(nibName: "PlanCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlanCell
        let obj = arrData[indexPath.row]
        cell.lblTime.text = obj.title
        cell.fillData(data: obj.data)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

public class Plan_Day {
    var title:String {
        
        get {
            return self.time.toString(format: .custom("HH:mm"))
        }
    }
    var time:Date = Date().adjust(hour: 0, minute: 0, second: 0)
    init(time:Date) {
        self.time = time
    }
    
    var data:[Plan_Data] = []
}
public class Plan_Data {
    
    
    var plan_title:String!
    var plan_time:Date = Date().adjust(hour: 0, minute: 0, second: 0)
    
    init(plan_title:String,plan_time:Date) {
        self.plan_title = plan_title
        self.plan_time = plan_time
    }
    
}
