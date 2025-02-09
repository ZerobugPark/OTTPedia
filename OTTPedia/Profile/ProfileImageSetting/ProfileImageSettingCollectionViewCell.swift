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
    func imageSetup(index: Int, selected: Bool) {
        
        imageView.image = UIImage(named: ImageList.shared.profileImageList[index])
        if !selected {
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = ColorList.darkGray.color.cgColor
            imageView.alpha = 0.5
            
        } else {
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = ColorList.main.color.cgColor
            imageView.alpha = 1
        }
        
        
        
        
    }
    
}
