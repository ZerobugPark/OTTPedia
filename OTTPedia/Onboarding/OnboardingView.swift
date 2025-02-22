//
//  OnboardingView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

import SnapKit

final class OnboardingView: BaseCollectionViewCell {

    let startButton = CustomButton(title: "시작하기")
    
    private let imageView = CustomImageView()
    private let titleLable = CustomLabel(boldStyle: false, fontSize: 25, italic: true, color: ColorList.white)
    private let subTitleLable = CustomLabel(boldStyle: false, fontSize: 14, italic: false, color: ColorList.white)
    
    
    override func configureHierarchy() {
        
        addSubview(imageView)
        addSubview(titleLable)
        addSubview(subTitleLable)
        addSubview(startButton)
        
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(titleLable.snp.top).offset(-4)
        }
        
        titleLable.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLable.snp.top).offset(-20)
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(30)
        }
        
        subTitleLable.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-30)
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(34)  
            
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(120)
            //make.height.equalTo(50)
            // 화면이 작아지면 작아질수록, 버튼의 사이즈는 작아지니까 고정 X
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 8.0) // 뷰의 너비기준으로 높이 비율 계산 즉, 너비 * 비율
            
        }
        
    }
    
    override func configureView() {
        
        let title = "Onboarding"
        let subtitle = "당신만의 영화 세상,\nOTTPedia를 시작해보세요."
        
        
        imageView.image = UIImage(named: "onboarding")
        
        titleLable.text = title
       
        subTitleLable.text = subtitle
        subTitleLable.numberOfLines = 2
        
       
        
        
    }
}
