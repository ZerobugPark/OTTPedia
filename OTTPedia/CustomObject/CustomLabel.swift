//
//  CustomLabel.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class CustomLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
    }
    
    // 컬러를 매개변수로 받고 정렬리 왼쪽일 때,
    convenience init(boldStyle: Bool, fontSize: CGFloat, color: UIColor) {
        self.init()
        font = boldStyle ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        textColor = color
        textAlignment = .left
        
    }
    
    
    // 컬러 변경 및 정렬이 센터이면서, 이탤릭체랑 비교
    convenience init(boldStyle: Bool, fontSize: CGFloat, italic: Bool, color: UIColor) {
        self.init()
        
        if italic {
            font = .italicSystemFont(ofSize: fontSize)
        } else {
            font = boldStyle ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        }
        textColor = color
        textAlignment = .center
        
        UIFont.italicSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


