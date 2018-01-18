//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension String {
    public func hk_toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
    
    public var hk_floatValue: Float {
        return (self as NSString).floatValue
    }
    
    static var hk_uniqueGUID:String {
        get {
            return UUID().uuidString
        }
    }
    
    public var hk_toJsonDict: Dictionary<String,AnyObject>?{
        return (try? JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8, allowLossyConversion: false)!, options: JSONSerialization.ReadingOptions.allowFragments)) as? Dictionary<String,AnyObject>
        
    }
    
    public func hk_range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    public func hk_toRange()->NSRange{
     
        let range = self.range(of: self)
        
       return NSMakeRange(self.characters.distance(from: self.startIndex, to: range!.lowerBound),self.characters.count)

    }
    
    public var hk_toNumericString:String{
        
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    public var hk_toDictionary:[AnyHashable: Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    public var hk_toArray:[[AnyHashable: Any]]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyHashable: Any]]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    public func hk_getFirstComponent(_ sperator:String = " ")->String{
        
        let arr = self.components(separatedBy: sperator)
        return arr.first ?? self
        
    }
    public func hk_getLastComponent(_ sperator:String = " ")->String{
        
        let arr = self.components(separatedBy: sperator)
        return arr.last ?? self
        
    }
    public func hk_isEmailValid()-> Bool {
        
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self.hk_trimWhiteSpace()!, options: [], range: NSMakeRange(0, self.hk_trimWhiteSpace()!.characters.count)) != nil
        
        
    }
    
    public func hk_isNumeric()->Bool {
        
        let regx = "\\d{0,5}(\\.\\d{0,2})?"
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self)
    }

    
    
}
extension String {
    
    
    public func hk_trimWhiteSpace()->String?{
        
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
        
    }
    
    public var hk_encodeURL:String{
        
        return self.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
    }
    
    public var hk_toRequest:URLRequest{
        
        
        return URLRequest(url: URL(string:self.hk_encodeURL)!)
    }
    
    public var hk_toURL:URL{
        
        return URL(string:self.hk_encodeURL)!
    }
    
    public func hk_htmlNormalString()->String{
        
        return self.replacingOccurrences(of: "&#8211;", with: "-")
            .replacingOccurrences(of: "&#8217;", with: "’")
            .replacingOccurrences(of: "&#038;", with: "&")
    }
}
