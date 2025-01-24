//
//  CustomImageView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class CustomImageView: UIImageView {
    
    
    init(cornerRadius: Bool) {
        super.init(frame: .zero)
        
        if cornerRadius {
            layer.cornerRadius = 10
            clipsToBounds = true
        }
        contentMode = .scaleToFill//.scaleAspectFit
        
    }
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        
    }
        
    
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

