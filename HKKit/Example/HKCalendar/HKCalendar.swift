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
import AFDateHelper

open class HKCalendarController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var viewDayTab: HKViewTab = HKViewTab()
    var containerView: UIView = UIView()
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    override open func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    

    fileprivate func setUp() {
        
        view.backgroundColor = .white
        view.addSubview(viewDayTab)
        view.addSubview(containerView)
        containerView.addSubview(pageController.view)

        constrain(viewDayTab, containerView) { (first, second) in
            
            first.width == first.superview!.width
            first.height == 20
            first.top == first.superview!.top
            first.centerX == first.superview!.centerX
            
            second.centerX == second.superview!.centerX
            second.top == first.bottom
            second.width == first.width
            second.bottom == second.superview!.bottom
            
            
            
            
        }
        
        constrain(pageController.view) { (view) in
            
            view.edges == view.superview!.edges
            
        }

        viewDayTab.font = UIFont.systemFont(ofSize: 9, weight: UIFontWeightMedium)
        viewDayTab.data = ENUM_WEEKDAY.days
        
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
//            guard let controller = pageViewController.viewControllers?.first as? HKCalendarContentController, let diaryViewer = controller.selectedDayView?.objDiaryViewer else {
//                return
//            }
//            self.dateChangeHandler(diaryViewer)
//            
//            guard let previous = previousViewControllers.last as? HKCalendarContentController, controller != previous else {
//                return
//            }
//            controller.selectedDayView?.setSelected(true)
//            previous.selectedDayView?.setSelected(false)
//            controller.refreshColors()
            
        }
        
    }

    
    fileprivate func getViewController(_ week: Date, selectedDay: Date? = nil) -> HKCalendarContentController? {
        
        let obj = HKCalendarContentController()
        obj.selectedWeek = week
        obj.selectedDay = selectedDay
//        obj.dateChangeHandler = { diaryViewer in
//            
//            self.dateChangeHandler(diaryViewer)
//            
//        }
        
        return obj
    
    }
    
    func updateWithDay(_ day: Date = Date().dateFor(.startOfDay), animated: Bool = false) {
        
        pageController.setViewControllers([getViewController(day.dateFor(.startOfWeek), selectedDay: day)!], direction: .forward, animated: animated, completion: nil)
    }
    
    func refreshTickColors() {
        
        guard let controller = pageController.viewControllers?.last as? HKCalendarContentController else {
            return
        }
        controller.refreshColors()
    }

    
}
class HKCalendarContentController: UIViewController {
    
    fileprivate var selectedDayView: HKCalenderDayView?
    fileprivate var selectedWeek: Date!
    fileprivate var selectedDay: Date?
    fileprivate var arrayViews: [HKCalenderDayView] = []
    
    
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
    
    func refreshColors() {
        
//        arrayViews.forEach { (dayView) in
//            dayView.objDiaryViewer = DiaryFunctions.getDiaryForTheDay(dayView.objDiaryViewer.date)
//            dayView.updateColors()
//            
//        }
        
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
        self.updateSelection(dayView)
        
    }
    
    fileprivate func updateSelection(_ dayView: HKCalenderDayView) {
        
        dayView.setSelected(true)
        selectedDayView?.setSelected(false)
        selectedDayView = dayView
    }
    
}

private class HKCalenderDayView: UIView {
    
    let lableWeek = UILabel()
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
        
        lableWeek.text = String(self.day.component(.day)!)
        lableWeek.textAlignment = .center
        lableWeek.numberOfLines = 0
        lableWeek.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        addSubview(backView)
        addSubview(lableWeek)

        self.setUpConstraints()
        self.updateColors()
        
    }
    
    func setUpConstraints() {
        
        constrain(lableWeek,backView) { (lableWeek,backView) in
            
            lableWeek.top == lableWeek.superview!.top
            lableWeek.leading == lableWeek.superview!.leading
            lableWeek.trailing == lableWeek.superview!.trailing
            lableWeek.bottom >= lableWeek.superview!.bottom
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
//        if objDiaryViewer.date.compare(.isInTheFuture) {
//            
//            self.alpha = 0.1
//            self.imgView.isHidden = true
//            
//        } else {
//            
//            let objAttribute = objDiaryViewer.attribute
//            
//            self.lableWeek.textColor = objAttribute.color
//            self.imgView.image = objAttribute.image
//            self.imgView.tintColor = objAttribute.color
//            
//        }
    }
    
    func setSelected(_ selected: Bool) {
        self.isSelected = selected
        if selected {
            lableWeek.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
            lableWeek.textColor = .white
            backView.backgroundColor = .blue
        } else {
            
            lableWeek.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
            lableWeek.textColor = .black
            backView.backgroundColor = .clear
        }
        
    }
 
    
}
