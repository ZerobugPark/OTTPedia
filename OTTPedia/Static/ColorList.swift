//
//  ColorList.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

enum ColorList {
    
    static let main = UIColor(named: "main")! // 옵셔널에 대한 불편함이 있음
    static let black = UIColor.black
    static let white = UIColor.white
    static let lightGray = UIColor(named: "lightGray")!
    static let darkGray = UIColor(named: "darkGray")!
    
//
//    case main
//    case black
//    case white
//    case lightGray
//    case darkGray
    
//    var color: UIColor {
//        switch self {
//        case .main:
//            return  #colorLiteral(red: 0, green: 0.6, blue: 0.8392156863, alpha: 1)
//        case .black:
//            return .black
//        case .white:
//            return .white
//        case .lightGray:
//            return  #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
//        case .darkGray:
//            return  #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
// 
//        }
//    }
    
}


// 확장을 통해서 하는게 더 나을까?
//extension UIColor {
//    class var mainColor: UIColor? { return UIColor(named: "main") }
//    class var lightGray: UIColor? { return UIColor(named: "lightGray") }
//    class var darkGray: UIColor? { return UIColor(named: "darkGray") }
//    
//}
