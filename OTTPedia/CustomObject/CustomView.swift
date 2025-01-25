//
//  CustomView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

class CustomView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        
        layer.cornerRadius = 10
        backgroundColor = ColorList.DarkGray.color
        clipsToBounds = true
   
    }
    

    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
