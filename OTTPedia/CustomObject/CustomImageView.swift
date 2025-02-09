//
//  CustomImageView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class CustomImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
    }
    
    convenience init(cornerRadius: Bool) {
        self.init()
        
        if cornerRadius {
            layer.cornerRadius = 10
            clipsToBounds = true
        }
        contentMode = .scaleToFill
        
    }
    
    convenience init(selected: Bool) {
        self.init()
        
        clipsToBounds = true
        
        if selected {
            layer.borderWidth = 3
            layer.borderColor = ColorList.main.cgColor
        } else {
            layer.borderWidth = 1
            layer.borderColor = ColorList.darkGray.cgColor
            alpha = 0.5
        }
        
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

