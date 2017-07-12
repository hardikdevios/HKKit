//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class RootViewController: UIViewController {
    public class func instance() -> Self {
        func inner<T: RootViewController>(type: T.Type) -> T {
            let type = self as UIViewController.Type
            let name = NSStringFromClass(type).components(separatedBy: ".").last!
            let instance = type.init(nibName: name, bundle: nil)
            return instance as! T
        }
        return inner(type: self)
    }
}

class MyViewController: RootViewController {
    var a:Int = 0
}
class SecondViewController: RootViewController {
    var b:Int = 0
}

let vc = SecondViewController.instance()
print(vc.b)

protocol Groupable:Hashable
{
    var parent: Self? { get }
    var children: Set<Self> { get }
}


let array = [2,3,5,7,3,1,8,9,10,2,4,1]

array.en
print(array.min())
//fileManager = FileManager.default
//// let documentDirectory = fileManager?.urls(for: .documentDirectory, in: .userDomainMask).first as String
//var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//path = path + name
//let image = #imageLiteral(resourceName: "Notifications")
//let imageData = UIImageJPEGRepresentation(image, 0.5)
//let bool = fileManager?.createFile(atPath: path, contents: imageData, attributes: nil)
//print("bool is \(bool)")
//return true
