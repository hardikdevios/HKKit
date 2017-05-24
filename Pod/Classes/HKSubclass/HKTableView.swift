//
//  HKTableView.swift
//  HKKit
//
//  Created by Hardik Shah on 24/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

open class HKTableView: UITableView {

    public var onLoadMore:(()->())?
    public typealias onViewUpdate = ((HKTableView)->(Int))
    open var onRows:onViewUpdate?

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
        
    }

    public func setUp(){
        
        self.keyboardDismissMode = .onDrag
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 50
        setEmptyData()
        setupDataSource()

    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = Int(scrollView.contentOffset.y)
        let maxOffset = Int(scrollView.contentSize.height - scrollView.frame.size.height)
        
        if (maxOffset - offset) < 0  {
            self.onLoadMore?()
        }
    }
    
    

}

extension HKTableView: UITableViewDelegate, UITableViewDataSource {
    
    public func setupDataSource(){
        self.delegate = self
        self.dataSource = self
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return onRows?(tableView as! HKTableView) ?? 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }

    
    
}
extension HKTableView: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    public func setEmptyData(){
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }
    
}
