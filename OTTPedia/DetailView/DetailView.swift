//
//  DetailView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

import SnapKit

final class DetailView: BaseView {
    
    
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    let infoLabel = CustomLabel(boldStyle: false, fontSize: 12, italic: false, color: ColorList.lightGray.color)
    
    override func configureHierarchy() {
        
        addSubview(scrollView)
        addSubview(pageControl)
        addSubview(infoLabel)
        
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(self)
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 1.75)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(self.scrollView.snp.bottom)
            make.centerX.equalTo(scrollView)
        }
        
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(15)
        }
  
        
    }
    
    override func configureView() {
   
       // scrollView.backgroundColor = .white
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        infoLabel.backgroundColor = .white
        
        pageControl.pageIndicatorTintColor = ColorList.lightGray.color
        pageControl.currentPageIndicatorTintColor = ColorList.white.color
        
    }

    

}
