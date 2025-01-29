//
//  ColorList.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

enum ColorList {
    
    case main
    case black
    case white
    case lightGray
    case darkGray
    
    var color: UIColor {
        switch self {
        case .main:
            return  #colorLiteral(red: 0, green: 0.6, blue: 0.8392156863, alpha: 1)
        case .black:
            return .black
        case .white:
            return .white
        case .lightGray:
            return  #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        case .darkGray:
            return  #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
 
        }
    }
    
}
