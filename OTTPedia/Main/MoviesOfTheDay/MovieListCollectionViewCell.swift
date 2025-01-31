//
//  MovieListCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/26/25.
//

import UIKit

import SnapKit
import Kingfisher

final class MovieListCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "MovieListCollectionViewCell"
    
    private let movieImage = CustomImageView(cornerRadius: true)
    private let movieTitleLabel = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white.color)
    private let overviewLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.white.color)
    
    private var likeButtonStatus = false
    
    let likeButton = UIButton()
    var delegate: PassMovieLikeDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(movieTitleLabel.snp.top).offset(-4)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(likeButton.snp.leading).inset(8)
            make.bottom.equalTo(overviewLabel.snp.top)
            make.height.equalTo(18)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(overviewLabel.snp.top)
            make.trailing.equalTo(contentView)
            make.size.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(16)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(30) //높이를 기준 잡아주지 않으면, 레이블의 텍스트 값을때, 다른 것들이 영역 침범함.
        }
        
    }
    
    override func configureView() {

        
        overviewLabel.numberOfLines = 2
        overviewLabel.lineBreakMode = .byTruncatingTail
        
        
    }
    
    func setupTrending(trend: Results) {
        
        if let path = trend.posterPath {
            let url = URL(string: Configuration.shared.secureURL + Configuration.PosterSizes.w500.rawValue + path)
            movieImage.kf.setImage(with: url)
        } else {
            movieImage.image = UIImage(systemName: "star.fill")
        }
        
        
        movieTitleLabel.text = trend.title
        overviewLabel.text = trend.overview
        
    
    }
    

    @objc private func likeButtonTapped(_ sender: UIButton) {
        likeButtonStatus.toggle()
        let image = likeButtonStatus ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: image), for: .normal)
        
 
        delegate?.likeButtonTapped(index: sender.tag, status: likeButtonStatus)
        
        
    }
    
    
}
