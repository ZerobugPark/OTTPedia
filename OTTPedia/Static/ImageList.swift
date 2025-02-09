//
//  imageList.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import Foundation
import UIKit

struct ImageList {
    let profileImageList: [UIImage] = [.profile0, .profile1, .profile2, .profile3,
                                       .profile4, .profile5, .profile6, .profile7,
                                       .profile8, .profile9, .profile10, .profile11]
    
//    let profileImageList = ["profile_0", "profile_1", "profile_2", "profile_3",
//                            "profile_4", "profile_5", "profile_6", "profile_7",
//                            "profile_8", "profile_9", "profile_10", "profile_11"]
    
    
    static let shared = ImageList()
    
    private init() { }
    
    
}
