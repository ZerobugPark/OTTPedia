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
    
    let dateLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray)
    let avgLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray)
    let genreLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray)
    let imageViews: [CustomImageView] = [CustomImageView(), CustomImageView(), CustomImageView()]
    
    let tableView = UITableView()
    
    private let stackView = UIStackView()
    
    
    override func configureHierarchy() {
        
        addSubview(scrollView)
        addSubview(pageControl)
        addSubview(stackView)
        stackView.addArrangedSubview(imageViews[0])
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(imageViews[1])
        stackView.addArrangedSubview(avgLabel)
        stackView.addArrangedSubview(imageViews[2])
        stackView.addArrangedSubview(genreLabel)
        addSubview(tableView)
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
        
        // MARK: - 개봉일, 평점, 장르
        stackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(16)
            make.centerX.equalTo(self)
            for i in 0..<imageViews.count{
                imageViews[i].snp.makeConstraints { make in
                    make.size.equalTo(14)
                }
            }
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
   
        let images = ["calendar", "star.fill", "film.fill"]
        
        for i in 0..<imageViews.count {
            imageViews[i].image = UIImage(systemName: images[i])
            imageViews[i].tintColor = ColorList.lightGray
            imageViews[i].isHidden = true // 자연스러운 전환을 위해서 히든 처리
        }
        
        tableView.bounces = false
        tableView.backgroundColor = ColorList.black
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        
        
        
        pageControl.pageIndicatorTintColor = ColorList.lightGray
        pageControl.currentPageIndicatorTintColor = ColorList.white
        
        
        
    }

    

}
