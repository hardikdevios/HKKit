//
//  PlanCell.swift
//  HKKit
//
//  Created by Hardik Shah on 14/09/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit
import HKKit
import Cartography
class PlanCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var seprator: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data:[Plan_Data]){
        
        
        
        mainStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        for obj in data {            
            mainStackView.addArrangedSubview(PlanEventView(title: obj.plan_title))
        }
        
    }
    
}

 class PlanEventView:UIStackView {
    
    let containerView:UIView = {
        
        let containerView = UIView()
        return containerView
        
    } ()
    
    

    let lblEvent:UILabel = {
        
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.medium)
        lbl.textColor = .white
        lbl.text = "Pre Workout Meal"
        return lbl
    } ()
    
    
    convenience init(title:String) {
        self.init(frame: CGRect.zero)
        self.lblEvent.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUp()
        
    }
    
    func setUp() {
        self.axis = .horizontal
        self.spacing = 1
        self.distribution = .fillProportionally
        self.alignment = .fill
        containerView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        containerView.addSubview(lblEvent)
        self.addArrangedSubview(containerView)
        self.constraintSetup()
    }
    func constraintSetup() {
        
        constrain(lblEvent) { view in
            
            view.edges == inset(view.superview!.edges, 5, 8, 5, 0)
        }
        constrain(containerView) { (view) in
            view.width == view.superview!.width
            view.height == view.superview!.height
            view.center == view.superview!.center
        }
        
    }
    
    
}
