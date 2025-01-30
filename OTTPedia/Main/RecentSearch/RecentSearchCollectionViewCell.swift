//
//  RecentSearchCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/30/25.
//

import UIKit

final class RecentSearchCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "RecentSearchCollectionViewCell"
    
    private let label = CustomLabel(boldStyle: false, fontSize: 13, color: ColorList.black.color)
    private let view = UIView()
    
    let button = UIButton()


    override func configureHierarchy() {
        contentView.addSubview(view)
        view.addSubview(label)
        view.addSubview(button)

    }
    
    override func configureLayout() {
        
        view.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(16)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.leading.equalTo(view).offset(8)
            
        }
        
        button.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.trailing.equalTo(view).inset(8)
            make.size.equalTo(12)
        }
 
        
    }
    
    override func configureView() {
        
        
        view.backgroundColor = ColorList.white.color
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = ColorList.black.color
        button.backgroundColor = .clear
    }
    
    func addRecnetSearchLable(text: String) {
        label.text = text//"1232132131221"
    }
    
}
