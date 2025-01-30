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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    
    override func configureHierarchy() {
        addSubview(movieImage)
        addSubview(movieTitle)
        addSubview(releaseDate)
        addSubview(stackView)
        

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
        
 
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(20)
            
            
        }
        
    }
    
    override func configureView() {
        
        movieTitle.numberOfLines = 2
        
       // genreLabel[0].text = "액션"
       // genreLabel[1].text = "애니메이션"
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        
        
    }
    
    
    func searchInfo(info: Results) {
        
        if let path = info.posterPath {
            let url = URL(string: Configuration.shared.secureURL + Configuration.PosterSizes.w500.rawValue + path)
            movieImage.kf.setImage(with: url)
        } else {
            movieImage.image = UIImage(systemName: "star.fill")
        }

        
        movieTitle.text = info.title
        releaseDate.text = info.releaseDate
        movieTitle.text = info.title
        findGenre(genres: info.genreIds)
        
    }
    
    private func findGenre(genres: [Int]) {
        
        let maxCount = genres.count > 2 ? 2 : genres.count
        
        if maxCount == 0 {
            return
        }
        
        genreLayout(count: maxCount)
        
        for i in 0..<maxCount {
            genreLabel[i].text = (Configuration.Genres(rawValue: genres[i])?.genre ?? "unknown")
        }
    }
    
    private func genreLayout(count: Int) {
       
        for i in 0..<count {
            
            let view = CustomView()
            view.layer.cornerRadius = 5
            genreView.append(view)
            stackView.addArrangedSubview(genreView[i])
            
            let label = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.white.color)
            label.textAlignment = .center
            
            genreLabel.append(label)
            genreView[i].addSubview(genreLabel[i])
        }
        
        for i in 0..<count {
            genreLabel[i].snp.makeConstraints { make in
                make.edges.equalTo(genreView[i]).inset(4)
                
            }
        }
        
        
    }
    
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        likeButtonStatus.toggle()
        let image = likeButtonStatus ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
}
