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

   
    }
    
    convenience init(cornerRadius: CGFloat) {
        self.init()
        
        layer.cornerRadius = cornerRadius
        backgroundColor = ColorList.darkGray
        clipsToBounds = true
    }
    

    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
