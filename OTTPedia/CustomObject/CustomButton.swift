//
//  CustomButton.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class CustomButton: UIButton {
    
    
    init() {
        super.init(frame: .zero)

    }
    
    convenience init(cornerRadius: CGFloat) {
        self.init()
        
        backgroundColor = ColorList.main
        titleLabel?.textColor = ColorList.white
        titleLabel?.font = .boldSystemFont(ofSize: 14)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    convenience init(title: String){
        self.init()
        configuration = .BasicButtonStyle(title: title)

        titleLabel?.font = .systemFont(ofSize: 16)
        clipsToBounds = true

     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
}


//@available (iOS 15.0, *)
extension CustomButton.Configuration {
    
    static func BasicButtonStyle(title: String) -> UIButton.Configuration {
       
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseForegroundColor = ColorList.main  // 텍스트 컬러
        configuration.baseBackgroundColor = .clear // 배경 컬러
        
        configuration.background.strokeColor = ColorList.main // 테두리 색상
        configuration.background.strokeWidth =  3 // 테두리 굵기
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .small
      
        return configuration
    }
}
