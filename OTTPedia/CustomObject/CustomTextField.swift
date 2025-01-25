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
        
        textAlignment = .left
        textColor = ColorList.white.color
        backgroundColor = .clear
        placeholder = "이름을 입력해주세요."
        borderStyle = .none
    }
    

    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
