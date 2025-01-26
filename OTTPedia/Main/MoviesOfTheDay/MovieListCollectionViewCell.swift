//
//  MovieListCollectionViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/26/25.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
  
    static let id = "MovieListCollectionViewCell"

    private let movieImage = CustomImageView(cornerRadius: true)
    private let movieTitleLabel = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white.color)
    private let descriptionLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.white.color)
    private let likeButton = UIButton()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy() {
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likeButton)
    }
    
    func configureLayout() {


        movieImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(movieTitleLabel.snp.top).offset(-8)
        }

        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(likeButton.snp.leading).offset(-8)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-4)
            make.height.equalTo(18)
        }

        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-4)
            make.trailing.equalTo(self)
            make.size.equalTo(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(16)
            make.horizontalEdges.equalTo(self)
            make.height.equalTo(30)
        }
        
    }
    
    func configureView() {
        print("hello")
        movieImage.backgroundColor = .red
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        movieTitleLabel.text = "ssssssssdsad"
        descriptionLabel.text = "dsmakldnalkdnslkandklsandlksmalkdmsalkdmnsaklmdksalmdkslamdkslamdkslamdsmakdmaldkmsalkdmaskld"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        movieTitleLabel.backgroundColor = .white
        contentView.backgroundColor = ColorList.black.color
        
    }
    
    
}
