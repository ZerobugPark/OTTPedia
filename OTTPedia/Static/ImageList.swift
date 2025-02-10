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
    
    
    static let shared = ImageList()
    
    private init() { }
    
    
}
