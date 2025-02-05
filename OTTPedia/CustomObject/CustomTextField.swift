//
//  CustomTextField.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class CustomTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(placeholder: String) {
        self.init()
        
        textAlignment = .left
        textColor = ColorList.white.color
        
        //Placeholder 색상 변경
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : ColorList.darkGray.color])
        
        backgroundColor = .clear
        borderStyle = .none
        
    }
    

    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
