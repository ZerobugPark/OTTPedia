//
//  CastCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

class CastCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "CastCollectionViewCell"
    
    private let profileImage = CustomImageView()
    private let koreanName = CustomLabel(boldStyle: true, fontSize: 15, color: ColorList.white.color)
    private let englishName = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray.color)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func configureHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(koreanName)
        contentView.addSubview(englishName)

    }
    
    override func configureLayout() {
        
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.size.equalTo(contentView.snp.width).multipliedBy(1.0 / 3.3)
        }
        
        koreanName.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(4)
            make.centerY.equalTo(contentView).offset(-8)
            make.height.equalTo(18)
        }
        
        englishName.snp.makeConstraints { make in
            make.top.equalTo(koreanName.snp.bottom).offset(4)
            make.leading.equalTo(profileImage.snp.trailing).offset(4)
            make.height.equalTo(15)
        }

        
    }
    
    override func configureView() {
        

        DispatchQueue.main.async {
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        }
        
        profileImage.backgroundColor = .red
        koreanName.backgroundColor = .green
        englishName.backgroundColor = .white
        koreanName.text = "231321312"
        englishName.text = "231321312"
    
    }


    
}
