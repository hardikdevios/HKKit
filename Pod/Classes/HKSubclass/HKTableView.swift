////
////  HKTableView.swift
////  HKKit
////
////  Created by Hardik Shah on 24/05/17.
////  Copyright © 2017 Hardik. All rights reserved.
////
//
//import UIKit
//import DZNEmptyDataSet
//
//open class HKTableView: UITableView {
//
//    public var onLoadMore:(()->())?
//
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//        setUp()
//    }
//    
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setUp()
//        
//    }
//
//    public func setUp(){
//        
//        self.keyboardDismissMode = .onDrag
//        self.rowHeight = UITableView.automaticDimension
//        self.estimatedRowHeight = 50
//        setEmptyData()
//
//    }
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        let offset = Int(scrollView.contentOffset.y)
//        let maxOffset = Int(scrollView.contentSize.height - scrollView.frame.size.height)
//        
//        if (maxOffset - offset) < 0  {
//            self.onLoadMore?()
//        }
//    }
//    
//    
//
//}
//
//
//extension HKTableView: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
//    
//    public func setEmptyData(){
//        self.emptyDataSetSource = self
//        self.emptyDataSetDelegate = self
//    }
//    
//}
