//
//  PosterCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "PosterCollectionViewCell"
    
    private let posterImage = CustomImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func configureHierarchy() {
        contentView.addSubview(posterImage)
    }
    
    override func configureLayout() {
        
        posterImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func setupPoster(info: ImageInfo) {
        
        let url = URL(string: Configuration.shared.secureURL + Configuration.PosterSizes.w342.rawValue + info.filePath)
        posterImage.kf.setImage(with: url)
        
    }
    
}
