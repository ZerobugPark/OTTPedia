//
//  ProfileUserDefaults.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import Foundation

class ProfileUserDefaults {
    
    static var imageIndex: Int {
        get {
            UserDefaults.standard.integer(forKey: "imageIndex")
        } set {
            UserDefaults.standard.set(newValue, forKey: "imageIndex")
        }
    }
    
}
