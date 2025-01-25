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
    }
    
    init(cornerRadius: Bool) {
        super.init(frame: .zero)
        
        if cornerRadius {
            layer.cornerRadius = 10
            clipsToBounds = true
        }
        contentMode = .scaleToFill//.scaleAspectFit
        
    }
    
    init(selected: Bool) {
        super.init(frame: .zero)
        clipsToBounds = true
        
        if selected {
            layer.borderWidth = 3
            layer.borderColor = ColorList.main.color.cgColor
        } else {
            layer.borderWidth = 1
            layer.borderColor = ColorList.DarkGray.color.cgColor
            alpha = 0.5
        }
        
    }
        
    
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

