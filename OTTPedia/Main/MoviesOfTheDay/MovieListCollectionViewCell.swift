//
//  MovieListCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/26/25.
//

import UIKit

import SnapKit
import Kingfisher

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let id = "MovieListCollectionViewCell"
    
    private let movieImage = CustomImageView(cornerRadius: true)
    private let movieTitleLabel = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white.color)
    private let         overviewLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.white.color)
    private let likeButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureHierarchy() {
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(        overviewLabel)
        contentView.addSubview(likeButton)
    }
    
    private func configureLayout() {
        
        
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(movieTitleLabel.snp.top).offset(-8)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(likeButton.snp.leading).offset(-8)
            make.bottom.equalTo(        overviewLabel.snp.top).offset(-4)
            make.height.equalTo(18)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(        overviewLabel.snp.top).offset(-4)
            make.trailing.equalTo(self)
            make.size.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(16)
            make.horizontalEdges.equalTo(self)
            make.height.equalTo(30)
        }
        
    }
    
    private func configureView() {
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        overviewLabel.numberOfLines = 2
        overviewLabel.lineBreakMode = .byTruncatingTail
        
        contentView.backgroundColor = ColorList.black.color
        
    }
    
    func updateTrending(trend: Results) {
        
        let url = URL(string: Configuration.shared.secureURL + Configuration.PosterSizes.w780.rawValue + trend.posterPath)
        movieImage.kf.setImage(with: url)
        movieTitleLabel.text = trend.title
        overviewLabel.text = trend.overview
    }
    
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    
}
