//
//  HKCalendar.swift
//  HKKit
//
//  Created by Hardik Shah on 12/09/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import AFDateHelper

open class HKCalendarController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    public var viewDayTab: HKViewTab = HKViewTab()
    public var containerView: UIView = UIView()
    public var lblFulldate:UILabel = UILabel()
    public var selectedDay:Date = Date().dateFor(.startOfDay)
    
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    public var dateChangeHandler: ((Date) -> Void)?

    override open func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    

    fileprivate func setUp() {
        
        
        view.backgroundColor = .white
        view.addSubview(viewDayTab)
        view.addSubview(containerView)
        view.addSubview(lblFulldate)

        containerView.addSubview(pageController.view)

        constrain(viewDayTab, containerView,lblFulldate) { (first, second, third) in
            
            first.width == first.superview!.width
            first.height == 16
            first.top == first.superview!.top
            first.centerX == first.superview!.centerX
            
            second.centerX == second.superview!.centerX
            second.top == first.bottom
            second.width == first.width
            
            
            
            third.top == second.bottom + 5
            third.width == third.superview!.width
            third.centerX == third.centerX
            third.bottom == third.superview!.bottom - 7
            
            
            
            
        }

        
        constrain(pageController.view) { (view) in
            
            view.edges == view.superview!.edges
            
        }
        lblFulldate.textAlignment = .center
        lblFulldate.text = self.getDayString()
        lblFulldate.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightMedium)
        viewDayTab.font = UIFont.systemFont(ofSize: 8, weight: UIFontWeightRegular)
        viewDayTab.textColor = .black
        viewDayTab.data = HK_ENUM_WEEKDAY.days
        
        pageController.dataSource = self
        pageController.delegate = self
        addChildViewController(pageController)
        
        pageController.didMove(toParentViewController: self)
        
        self.updateWithDay(animated:true)
    }
   
   
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let obj = viewController as? HKCalendarContentController else {
            return nil
        }
        return getViewController(obj.selectedWeek.dateFor(.startOfWeek).adjust(.day, offset: -7))
        
    }
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let obj = viewController as? HKCalendarContentController else {
            return nil
        }
        return getViewController(obj.selectedWeek.dateFor(.endOfWeek).adjust(.day, offset: 1))
        
    }
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            guard let controller = pageViewController.viewControllers?.first as? HKCalendarContentController, let day = controller.selectedDayView?.day else {
                return
            }
            self.selectedDay = day
            self.dateChangeHandler?(day)
            self.lblFulldate.text = self.getDayString(day: day)
            guard let previous = previousViewControllers.last as? HKCalendarContentController, controller != previous else {
                return
            }
            controller.selectedDayView?.setSelected(true)
            previous.selectedDayView?.setSelected(false)

        }
        
    }

    
    fileprivate func getViewController(_ week: Date,day:Date? = nil ) -> HKCalendarContentController? {
        
        let obj = HKCalendarContentController()
        obj.selectedWeek = week
        obj.selectedDay = day
        obj.dateChangeHandler = { day in
            
            self.lblFulldate.text = self.getDayString(day: day)
            self.dateChangeHandler?(day)
            
        }
        
        return obj
    
    }
    
    func updateWithDay(_ day: Date = Date().dateFor(.startOfDay), animated: Bool = false) {
        
        pageController.setViewControllers([getViewController(day.dateFor(.startOfWeek), day:selectedDay)!], direction: .forward, animated: animated, completion: nil)
    }
    
  
    func getDayString(day:Date = Date())->String{
        
        return day.toString(format: DateFormatType.custom("EEEE MMMM dd, yyyy"))
    }
    
}
class HKCalendarContentController: UIViewController {
    
    fileprivate var selectedDayView: HKCalenderDayView?
    fileprivate var selectedWeek: Date!
    fileprivate var selectedDay: Date?
    fileprivate var arrayViews: [HKCalenderDayView] = []
    var dateChangeHandler: ((Date) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        
        for i in 0..<7 {
            
            let  actualeDate = selectedWeek.adjust(.day, offset:i)
            
            let dayView = HKCalenderDayView(day: actualeDate)
            view.addSubview(dayView)
            dayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.daySelect(_:))))
            arrayViews.append(dayView)
            
            if selectedDayView != nil {
                continue
            }
            
            if selectedDay?.compare(.isSameDay(as: actualeDate)) == true {
                
                selectedDayView = dayView
            } else if selectedWeek.compare(.isThisWeek) && actualeDate.compare(.isToday) {
                selectedDayView = dayView
                
            } else if i == 0 && selectedDay == nil && !selectedWeek.compare(.isThisWeek) {
                selectedDayView = dayView
                
            }
            
        }
        
        selectedDayView?.setSelected(true)
        self.setUpConstraints(arrayViews)
    }
    
 
    func setUpConstraints(_ arrayViews: [UIView]) {
        
        constrain(arrayViews) { (layoutViews) in
            
            for (index, aView) in layoutViews.enumerated() {
                
                aView.height == aView.superview!.height
                aView.width == aView.superview!.width / 7 
                aView.top == aView.superview!.top
                aView.centerY == aView.superview!.centerY
                
                if index == 0 {
                    aView.leading == aView.superview!.leading
                } else {
                    aView.leading == layoutViews[index - 1].trailing
                }
                
                
            }
            
        }
        
    }
    
    func daySelect(_ gesture: UITapGestureRecognizer) {
        
        guard let dayView = gesture.view as? HKCalenderDayView, dayView != selectedDayView  else {
            return
        }
        self.selectedDay = dayView.day
        self.updateSelection(dayView)
        self.dateChangeHandler?(dayView.day)

        
    }
    
    fileprivate func updateSelection(_ dayView: HKCalenderDayView) {
        
        dayView.setSelected(true)
        selectedDayView?.setSelected(false)
        selectedDayView = dayView
    }
    
}

private class HKCalenderDayView: UIView {
    
    let lblday = UILabel()
    var day: Date!
    let backView:UIView = UIView()
    var isSelected:Bool = false
    
    convenience init(day: Date, isSelected: Bool = false) {
        self.init(frame:CGRect.zero)
        self.day = day
        self.isSelected = isSelected
    
        self.setUp()
        self.setSelected(isSelected)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUp()
        
    }
    
    func setUp() {
        
        lblday.text = String(self.day.component(.day)!)
        lblday.textAlignment = .center
        lblday.numberOfLines = 0
        addSubview(backView)
        addSubview(lblday)

        self.setUpConstraints()
        self.updateColors()
        
    }
    
    func setUpConstraints() {
        
        constrain(lblday,backView) { (lblday,backView) in
            
            lblday.top == lblday.superview!.top
            lblday.leading == lblday.superview!.leading
            lblday.trailing == lblday.superview!.trailing
            lblday.bottom >= lblday.superview!.bottom
            backView.center == backView.superview!.center
            backView.height == 30
            backView.width == 30
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = backView.frame.width / 2
    }
    
    func updateColors() {
        
        if self.day.compare(.isToday) {
            
            
        }else{
            
        }

    }
    
    func setSelected(_ selected: Bool) {
        self.isSelected = selected
        if selected {
            lblday.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
            lblday.textColor = .white
            backView.backgroundColor = MAIN_COLOR
            if self.day.compare(.isToday) {
                self.backView.backgroundColor = UIColor.red.withAlphaComponent(0.7)
            }
            
        } else {
            
            lblday.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
            lblday.textColor = .black
            
            backView.backgroundColor = .clear
            if self.day.compare(.isToday) {
                self.lblday.textColor = UIColor.red.withAlphaComponent(0.7)
            }
            
            if self.day.compare(.isWeekend) {
                
                lblday.textColor = UIColor.black.withAlphaComponent(0.3)

            }
            
        }
        
    }
 
    
}
