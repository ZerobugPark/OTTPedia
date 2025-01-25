//
//  CustomLabel.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class CustomLabel: UILabel {
    
    
    init(boldStyle: Bool, fontSize: CGFloat) {
        super.init(frame: .zero)
        font = boldStyle ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
    }
    
    init(boldStyle: Bool, fontSize: CGFloat, italic: Bool) {
        super.init(frame: .zero)
        
        if italic {
            font = .italicSystemFont(ofSize: fontSize)
        } else {
            font = boldStyle ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        }
        textColor = ColorList.white.color
        textAlignment = .center
        
        UIFont.italicSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


