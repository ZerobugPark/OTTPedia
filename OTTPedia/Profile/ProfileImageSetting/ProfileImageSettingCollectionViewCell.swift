//
//  ProfileImageSettingCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class ProfileImageSettingCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "ProfileImageSettingCollectionViewCell"
    
    let imageView = CustomImageView(selected: false)
    
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    override func configureView() {
    
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
    
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        if imageView.frame.width == 0 {
//            contentView.layoutIfNeeded() // 강제로 Auto Layout 적용
//        }
//        
//        print("layoutSubviews - imageView frame: \(imageView.frame)") // 여기서 크기가 정해짐
//        imageView.layer.cornerRadius = imageView.frame.width / 2
//    }
//    
    

    
    func imageSetup(data: (currendIdx: Int, status: Bool) ) {
        
        imageView.image = ImageList.shared.profileImageList[data.currendIdx]
        if !data.status {
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = ColorList.darkGray.cgColor
            imageView.alpha = 0.5
            
        } else {
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = ColorList.main.cgColor
            imageView.alpha = 1
        }
        
    }
    
}
