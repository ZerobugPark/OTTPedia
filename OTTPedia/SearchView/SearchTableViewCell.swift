//
//  SearchTableViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    static let id = "SearchTableViewCell"
    
    private let movieImage = CustomImageView(cornerRadius: true)
    private let movieTitle = CustomLabel(boldStyle: true, fontSize: 15, color: ColorList.white.color)
    private let releaseDate = CustomLabel(boldStyle: false, fontSize: 13, color: ColorList.lightGray.color)
    
    private let stackView = UIStackView()
    
    private var genreView: [CustomView] = []
    private var genreLabel: [CustomLabel] = []
    private let likeButton = UIButton()
    private var likeButtonStatus = false
    
    private let genreCount = 2
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    
    override func configureHierarchy() {
        addSubview(movieImage)
        addSubview(movieTitle)
        addSubview(releaseDate)
        addSubview(stackView)
        
        for i in 0..<genreCount {
            
            let view = CustomView()
            view.layer.cornerRadius = 5
            genreView.append(view)
            stackView.addArrangedSubview(genreView[i])
            
            let label = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.white.color)
            label.textAlignment = .center
            
            genreLabel.append(label)
            genreView[i].addSubview(genreLabel[i])
        }
        
        addSubview(likeButton)
        
    }
    
    override func configureLayout() {
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(16)
            make.width.equalTo(contentView.snp.width).multipliedBy(1.0 / 3.5)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(movieImage.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(8)
            make.height.greaterThanOrEqualTo(17)
            
        }
        
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(4)
            make.trailing.equalTo(contentView).inset(8)
            make.leading.equalTo(movieImage.snp.trailing).offset(8)
            make.height.equalTo(15)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(movieImage.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(likeButton.snp.leading).inset(8)
            
        }
        
        for i in 0..<genreCount {
            genreLabel[i].snp.makeConstraints { make in
                make.edges.equalTo(genreView[i]).inset(4)
                
            }
        }
        
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(20)
            
            
        }
        
    }
    
    override func configureView() {
        
        
        movieImage.backgroundColor = .red
        
      
        
        movieTitle.text = "123213dfsfsfdsfsfdsfsfsfsfsfsfsfsfsfsfsdfsfsfsfsfdsfsfsf"
        movieTitle.numberOfLines = 2
        releaseDate.text = "123213123213"
        
        genreLabel[0].text = "액션"
        genreLabel[1].text = "애니메이션"
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        
        
    }
    
    
    func setupLabel(title: String) {
        
    }
    
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        likeButtonStatus.toggle()
        let image = likeButtonStatus ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
}
