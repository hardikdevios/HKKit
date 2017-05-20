//
//  Misc+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 20/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

extension Alamofire.SessionManager
{
    fileprivate func cancelTasksByUrl(_ tasks: [URLSessionTask], url: String)
    {
        
        for task in tasks
        {
            guard let string = task.currentRequest?.url?.description else{
                continue
            }
            if string.hasPrefix(MAIN_URL + url)
            {
                task.cancel()
            }
        }
    }
    
    func cancelRequests(_ url: String)
    {
        self.session.getTasksWithCompletionHandler
            {
                (dataTasks, uploadTasks, downloadTasks) -> Void in
                
                self.cancelTasksByUrl(dataTasks     as [URLSessionTask], url: url)
                self.cancelTasksByUrl(uploadTasks   as [URLSessionTask], url: url)
                self.cancelTasksByUrl(downloadTasks as [URLSessionTask], url: url)
        }
    }
}


//

extension UILabel{
    
    func getFirstComponent(_ sperator:String = " ")->String{
        return self.text!.getFirstComponent()
    }
}


extension Dictionary {
    
    public var toJsonString: String?{
        return NSString(data:try! JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted), encoding:String.Encoding.utf8.rawValue) as? String
        
    }
    
}

extension UITextField {
    
    public func getIndexPathForTableView(for tableView:UITableView)->IndexPath?{
        
        return tableView.indexPathForRow(at: (self.superview?.convert(self.frame.origin, to:tableView))!)
        
    }
}



extension String {
    
    var toNumericString:String{
        
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    var toDictionary:[AnyHashable: Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    var toArray:[[AnyHashable: Any]]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyHashable: Any]]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    func getFirstComponent(_ sperator:String = " ")->String{
        
        let arr = self.components(separatedBy: sperator)
        return arr.first ?? self
        
    }
    func getLastComponent(_ sperator:String = " ")->String{
        
        let arr = self.components(separatedBy: sperator)
        return arr.last ?? self
        
    }
    public func isEmailValid()-> Bool {
        
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self.trimWhiteSpace()!, options: [], range: NSMakeRange(0, self.trimWhiteSpace()!.characters.count)) != nil
        
        
    }
    
    public func isNumeric()->Bool {
        
        let regx = "\\d{0,5}(\\.\\d{0,2})?"
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self)
    }
    
    
}

extension UITableView {
    //set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
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

extension NSManagedObject {
    
    
    var toDict:[AnyHashable: Any]{
        
        
        return self.dictionaryWithValues(forKeys: Array(self.entity.attributesByName.keys))
        
    }
}
extension Array {
    
    
    var toDictArrayForManagedObject:[[AnyHashable: Any]]{
        
        var temp = [[AnyHashable: Any]]()
        for obj in self{
            
            guard let obj = obj as? NSManagedObject else{
                continue
            }
            
            temp.append(obj.toDict)
        }
        
        return temp
        
    }
}
extension UILabel {
    
    
    
    func setAttributeString(_ mainString:String,attributeString:String,attributes:[String:Any]){
        
        let range = mainString.range(of: attributeString, options: NSString.CompareOptions.caseInsensitive)
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string:mainString)
        
        if range != nil {
            
            attrString.addAttributes(attributes, range: NSMakeRange((mainString.characters.distance(from: mainString.startIndex, to: range!.lowerBound)),attributeString.characters.count))
            self.attributedText = attrString
            
        }else{
            self.text = mainString
        }
        
    }
    
    
    func setAttributesString(_ mainString:String,attributeStrings:[String],total_attributes:[[String:Any]]) {
        
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string:mainString)
        
        for (index,string) in attributeStrings.enumerated() {
            
            let range = mainString.range(of: string, options: NSString.CompareOptions.caseInsensitive)
            
            if range != nil {
                
                attrString.addAttributes(total_attributes[index], range: NSMakeRange((mainString.characters.distance(from: mainString.startIndex, to: range!.lowerBound)),string.characters.count))
                
                
            }else{
                continue
            }
            
        }
        self.attributedText = attrString
        
    }
}

extension UIButton {
    
    
    func appleBootStrapTheme(_ color:UIColor = MAIN_COLOR){
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 2
        self.layer.borderColor = color.cgColor
        self.setTitleColor(color, for: UIControlState())
    }
    
    func setAttributeString(_ mainString:String,attributeString:String,attributes:[String:Any]){
        
        let range = mainString.range(of: attributeString, options: NSString.CompareOptions.caseInsensitive)
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string:mainString)
        
        if range != nil {
            
            attrString.addAttributes(attributes, range: NSMakeRange((mainString.characters.distance(from: mainString.startIndex, to: range!.lowerBound)),attributeString.characters.count))
            self.setAttributedTitle(attrString, for: UIControlState())
            
        }else{
            self.setTitle(mainString, for: UIControlState())
            
        }
        
    }
}


extension UIViewController {
    
    public func isUIViewControllerPresentedAsModal() -> Bool {
        
        
        if((self.presentingViewController) != nil) {
            return true
        }
        
        if(self.presentingViewController?.presentedViewController == self) {
            return true
        }
        
        if(self.navigationController?.presentingViewController?.presentedViewController == self.navigationController) {
            return true
        }
        
        if((self.tabBarController?.presentingViewController?.isKind(of: UITabBarController.self)) != nil) {
            return true
        }
        
        return false
    }
}



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
}







extension Array {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
extension UIPickerView {
    
    func stopScrolling() {
        
        let delegate = self.delegate
        let dataSource = self.dataSource
        self.delegate = nil
        self.dataSource = nil
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    
    
}
extension RangeReplaceableCollection where Iterator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
}



public func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedSame
}

public func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}

public func >(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedDescending
}

func += <KeyType, ValueType> (left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}



extension UIViewController  {
    
    
    func setUpAddClick(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(UIViewController.addClick))
        
        
    }
    
    func addClick(){
        
    }
    
}




private var xoAssociationKey: UInt8 = 0


extension UIViewController {
    
    
    var tbl_pickerIndexPath: IndexPath! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? IndexPath
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    func tbl_displayInLinepickerAtIndextPath(_ indexpath:IndexPath!,tableView:UITableView)->Void{
        
        tableView.beginUpdates()
        
        let before = tbl_pickerIsBefore(indexpath)
        let sameCellClicked = tbl_isSameCelclicked(indexpath)
        
        if self.tbl_hasInlinePicker() && sameCellClicked{
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: self.tbl_pickerIndexPath.row, section: self.tbl_pickerIndexPath.section)], with: .fade)
            tableView.endUpdates()
            self.tbl_pickerIndexPath = nil
            
        }
        
        if (!sameCellClicked)
        {
            
            
            let rowToReveal:NSInteger! = (before ? indexpath.row-1:indexpath.row)
            
            let indexpathRowtoRivel:IndexPath! = IndexPath(row: rowToReveal, section: indexpath.section)
            self.tbl_insertPickeratIndexPath(indexpathRowtoRivel,tableView:tableView)
            
            self.tbl_pickerIndexPath = IndexPath(row: indexpathRowtoRivel.row + 1, section: indexpathRowtoRivel.section)
            
        }
        
        tableView.deselectRow(at: indexpath, animated: true)
        
        tableView.endUpdates()
        
        
    }
    func tbl_indexPathHasPicker(_ indexPath:IndexPath!)->Bool{
        
        return (self.tbl_hasInlinePicker() && self.tbl_pickerIndexPath.row == indexPath.row && self.tbl_pickerIndexPath.section == indexPath.section);
        
        
    }
    
    
    func tbl_hasInlinePicker()->Bool{
        
        
        if((self.tbl_pickerIndexPath) != nil){
            return true
        }
        return false
    }
    
    func tbl_pickerIsBefore(_ indexpath:IndexPath)->Bool{
        
        var before:Bool = false
        if self.tbl_hasInlinePicker(){
            before = self.tbl_pickerIndexPath.row < (indexpath as NSIndexPath).row && self.tbl_pickerIndexPath.section == (indexpath as NSIndexPath).section
        }
        return before
    }
    
    func tbl_isSameCelclicked(_ indexpath:IndexPath)->Bool{
        
        var sameCellClicked:Bool = false;
        
        if (self.tbl_pickerIndexPath) != nil {
            sameCellClicked = (self.tbl_pickerIndexPath.row - 1 == (indexpath as NSIndexPath).row && self.tbl_pickerIndexPath.section == (indexpath as NSIndexPath).section)
        }
        return sameCellClicked
    }
    
    func tbl_hasInlinePicker(_ section:Int)->Bool{
        
        
        if(self.tbl_pickerIndexPath != nil && self.tbl_pickerIndexPath.section == section){
            return true
        }
        return false
    }
    func tbl_insertPickeratIndexPath(_ indexpath:IndexPath!,tableView:UITableView)->Void{
        tableView.beginUpdates()
        if self.tbl_hasInlinePicker() {
            tableView.deleteRows(at: [IndexPath(row: self.tbl_pickerIndexPath.row, section: self.tbl_pickerIndexPath.section)], with: .fade)
            
        }
        tableView.insertRows(at: [IndexPath(row: indexpath.row + 1, section: indexpath.section)], with: .fade)
        tableView.endUpdates()
    }
}

