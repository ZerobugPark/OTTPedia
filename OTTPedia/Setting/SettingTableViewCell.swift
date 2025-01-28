//
//  SettingTableViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

import SnapKit

class SettingTableViewCell: BaseTableViewCell {

    static let id = "SettingTableViewCell"
    
    private let content = CustomLabel(boldStyle: false, fontSize: 16, color: ColorList.white.color)


    override func configureHierarchy() {
        contentView.addSubview(content)
        
    }
    
    override func configureLayout() {
        content.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView)
        }

        
    }
  
    
    
    func setupContent(title: String) {
        content.text = title

    }

    


}
