//
//  CastCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

import SnapKit

final class CastCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "CastCollectionViewCell"
    
    private let profileImage = CustomImageView()
    private let koreanName = CustomLabel(boldStyle: true, fontSize: 13, color: ColorList.white.color)
    private let characterName = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray.color)
    
    
    override func configureHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(koreanName)
        contentView.addSubview(characterName)

    }
    
    override func configureLayout() {
        
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.size.equalTo(contentView.snp.width).multipliedBy(1.0 / 3.3)
        }
        
        koreanName.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.centerY.equalTo(contentView).offset(-12)
            make.width.equalTo(contentView).multipliedBy(1.0 / 1.6)
            make.height.equalTo(15)
        }
        
        characterName.snp.makeConstraints { make in
            make.top.equalTo(koreanName.snp.bottom).offset(6)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.width.equalTo(contentView).multipliedBy(1.0 / 1.6)
            make.height.equalTo(14)
        }

        
    }
    
    override func configureView() {
        
        DispatchQueue.main.async {
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        }
    }

    func setupCast(info: CastInfo) {
        
        if let path = info.profilePath {
            let url = URL(string: Configuration.shared.secureURL + Configuration.ProfileSizes.w185.rawValue + path)
            profileImage.kf.setImage(with: url)
        } else {
            profileImage.image = UIImage(systemName: "star.fill")
        }
        
        koreanName.text = info.name
        characterName.text = info.character
        
    }

    
}
