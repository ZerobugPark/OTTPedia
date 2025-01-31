//
//  ProfileUserDefaults.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import Foundation

class ProfileUserDefaults {
    
    static var isEnroll: Bool {
        get {
            UserDefaults.standard.bool(forKey: "enroll")
        } set {
            UserDefaults.standard.set(newValue, forKey: "enroll")
        }
    }
    
    static var imageIndex: Int {
        get {
            UserDefaults.standard.integer(forKey: "imageIndex")
        } set {
            UserDefaults.standard.set(newValue, forKey: "imageIndex")
        }
    }
    
    static var id: String {
        get {
            UserDefaults.standard.string(forKey: "id") ?? "Unknown"
        } set {
            UserDefaults.standard.set(newValue, forKey: "id")
        }
    }
    
    static var resgisterDate: String {
        get {
            UserDefaults.standard.string(forKey: "date") ?? "No date"
        } set {
            UserDefaults.standard.set(newValue, forKey: "date")
        }
    }
    
    static var likeMoive: [String: Bool] {
        get {
            UserDefaults.standard.dictionary(forKey: "likeMovie") as? [String: Bool] ?? ["nil" : false]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "likeMovie")
        }
    }
    
    static var recentSearh: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "search") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "search")
        }
    }
}
