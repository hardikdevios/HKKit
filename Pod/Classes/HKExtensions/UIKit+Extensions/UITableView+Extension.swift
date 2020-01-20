
//
//  UITableView+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 23/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import CoreData
import UIKit
extension UITableView {
    
    public func hk_headerSizeFit(padding:CGFloat = 0){
        
        guard let headerView = self.tableHeaderView else {
            return
        }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height + padding
        headerView.frame = frame
        self.tableHeaderView = headerView
    }
    
    public func hk_footerSizeFit(){
        
        guard let headerView = self.tableFooterView else {
            return
        }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        self.tableFooterView = headerView
    }
    
    public func hk_setAndLayoutTableHeaderView(_ header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        self.tableHeaderView = header
    }
    
}
//private var xoAssociationKeyTableView: UInt8 = 0
//
//extension UIViewController:NSFetchedResultsControllerDelegate {
//    
//    
//    public var hk_tbl_extended: UITableView! {
//        get {
//            return objc_getAssociatedObject(self, &xoAssociationKeyTableView) as? UITableView
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, &xoAssociationKeyTableView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
//        }
//    }
//    
//    
//    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        self.hk_tbl_extended.beginUpdates()
//    }
//    
//    /* called:
//     - when a new model is created
//     - when an existing model is updated
//     - when an existing model is deleted */
//    
//    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
//                           didChange object: Any,
//                           at indexPath: IndexPath?,
//                           for type: NSFetchedResultsChangeType,
//                           newIndexPath: IndexPath?) {
//        
//        
//        switch(type) {
//            
//        case .insert:
//            if let newIndexPath = newIndexPath {
//                self.hk_tbl_extended.insertRows(at: [newIndexPath],
//                                             with:UITableViewRowAnimation.automatic)
//            }
//            
//        case .delete:
//            if let indexPath = indexPath {
//                self.hk_tbl_extended.deleteRows(at: [indexPath],
//                                             with: UITableViewRowAnimation.automatic)
//            }
//            
//        case .update:
//            if let indexPath = indexPath {
//                self.hk_tbl_extended.reloadRows(at: [indexPath],
//                                             with: UITableViewRowAnimation.none)
//            }
//            
//        case .move:
//            if let indexPath = indexPath {
//                if let newIndexPath = newIndexPath {
//                    self.hk_tbl_extended.deleteRows(at: [indexPath],
//                                                 with: UITableViewRowAnimation.automatic)
//                    self.hk_tbl_extended.insertRows(at: [newIndexPath],
//                                                 with: UITableViewRowAnimation.automatic)
//                }
//            }
//        }
//        
//        
//    }
//    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
//                           didChange sectionInfo: NSFetchedResultsSectionInfo,
//                           atSectionIndex sectionIndex: Int,
//                           for type: NSFetchedResultsChangeType)
//    {
//        switch(type) {
//            
//        case .insert:
//            self.hk_tbl_extended.insertSections(IndexSet(integer: sectionIndex),
//                                             with: UITableViewRowAnimation.bottom)
//            
//        case .delete:
//            self.hk_tbl_extended.deleteSections(IndexSet(integer: sectionIndex),
//                                             with: UITableViewRowAnimation.bottom)
//            
//        default:
//            break
//        }
//        
//    }
//    
//    
//    
//    /* called last
//     tells `UITableView` updates are complete */
//    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        self.hk_tbl_extended.endUpdates()
//    }
//    
//    
//}
//
//
