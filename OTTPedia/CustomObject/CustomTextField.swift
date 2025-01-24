//
//  CustomTextField.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class CustomTextField: UITextField {
    
    
    init(boldStyle: Bool, fontSize: CGFloat) {
        super.init(frame: .zero)
        font = boldStyle ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
    }
    

    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
