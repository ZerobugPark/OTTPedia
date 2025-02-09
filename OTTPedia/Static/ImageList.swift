//
//  imageList.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import Foundation
import UIKit

struct ImageList {
    
    let profileImageList = ["profile_0", "profile_1", "profile_2", "profile_3",
                            "profile_4", "profile_5", "profile_6", "profile_7",
                            "profile_8", "profile_9", "profile_10", "profile_11"]
    
    
    let test = UIImage(resource: .profile0)
    
    
    
    
    static let shared = ImageList()
    
    private init() { }
    
    
}
