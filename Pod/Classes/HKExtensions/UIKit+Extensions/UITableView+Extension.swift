
//
//  UITableView+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 23/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
extension UITableView {
    
    func headerSizeFit(padding:CGFloat = 0){
        
        guard let headerView = self.tableHeaderView else {
            return
        }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height + padding
        headerView.frame = frame
        self.tableHeaderView = headerView
    }
    
    func footerSizeFit(){
        
        guard let headerView = self.tableFooterView else {
            return
        }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        self.tableFooterView = headerView
    }
    
    func setAndLayoutTableHeaderView(_ header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        self.tableHeaderView = header
    }
    
}


