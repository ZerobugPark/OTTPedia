//
//  MainView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class MainView: BaseView {
    
    let view = CustomView()
    let imageView = CustomImageView(selected: true)
    let nameLabel = CustomLabel(boldStyle: true, fontSize: 16, color:  ColorList.white.color)
    let likeStorageButton = CustomButton()
    let removeAllButton = UIButton()
    let recentInfoLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray.color)
    let movieListView = UIView()
    let secondSection = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white.color)
    
    private let firstSection = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white.color)
    private let stackView = UIStackView()
    private let recentSearchView = UIView()
    
    
    private let dateLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray.color)
    private let chevronImage = CustomImageView()
    
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    
    
    override func configureHierarchy() {
        addSubview(view)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(chevronImage)
        addSubview(likeStorageButton)
        addSubview(stackView)
        stackView.addArrangedSubview(recentSearchView)
        stackView.addArrangedSubview(movieListView)
        
        recentSearchView.addSubview(firstSection)
        recentSearchView.addSubview(removeAllButton)
        recentSearchView.addSubview(recentInfoLabel)
        
        movieListView.addSubview(secondSection)
        movieListView.addSubview(collectionView)
        //addSubview(tableView)
        
        
    }
    
    override func configureLayout() {
        
        view.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 3.5)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(8)
            make.leading.equalTo(view).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(1.0 / 6.5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView).offset(-4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalTo(view).inset(50)
            make.height.equalTo(18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalTo(view).inset(50)
            make.height.equalTo(14)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.trailing.equalTo(view).inset(16)
            make.size.equalTo(imageView.snp.width).multipliedBy(1.0 / 2.5)
        }
        
        likeStorageButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(8)
            make.bottom.equalTo(view).inset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        recentSearchView.snp.makeConstraints { make in
            make.top.equalTo(stackView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(stackView)
            make.height.equalTo(70)
        }
        
        firstSection.snp.makeConstraints { make in
            make.top.equalTo(recentSearchView)
            make.leading.equalTo(recentSearchView).offset(16)
            make.height.equalTo(18)
        }
        
        removeAllButton.snp.makeConstraints { make in
            make.top.equalTo(recentSearchView)
            make.trailing.equalTo(recentSearchView).inset(4)
            make.height.equalTo(14)
        }
        
        recentInfoLabel.snp.makeConstraints { make in
            make.center.equalTo(recentSearchView).offset(2)
            make.height.equalTo(14)
        }
        
        movieListView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(stackView)
            make.bottom.equalTo(stackView)
        }
        
        secondSection.snp.makeConstraints { make in
            make.top.equalTo(movieListView)
            make.leading.equalTo(movieListView).offset(16)
            make.height.equalTo(18)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(secondSection.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(movieListView)
            make.bottom.equalTo(movieListView)
        }
        

    }
    
    override func configureView() {
        
        recentSearchView.backgroundColor = ColorList.black.color
        movieListView.backgroundColor = .red
        collectionView.backgroundColor = .black
        
        imageView.image = UIImage(named: ImageList.shared.profileImageList[0])
        
        view.isUserInteractionEnabled = true // 뷰에도 터치 가능하게

        nameLabel.text = "안녕하세요안녕하세요"

        dateLabel.text = "25.01.23 가입"

        chevronImage.image = UIImage(systemName: "chevron.compact.right")
        chevronImage.tintColor = ColorList.lightGray.color
        
        likeStorageButton.setTitle("18 개의 무비박스 보관중", for: .normal)
        
        stackView.axis = .vertical
        stackView.spacing = 4
        
        firstSection.text = "최근검색어"
        secondSection.text = "오늘의 영화"
        recentInfoLabel.text = "최근 검색어 내역이 없습니다."
        
        let buttonTitle = "전체 삭제"
        removeAllButton.setTitle(buttonTitle, for: .normal)
        removeAllButton.setTitleColor(ColorList.main.color, for: .normal)
        removeAllButton.titleLabel?.font = .systemFont(ofSize: 12)
        
        
        
        
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 2
        
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 1.5
      
        print(objectWidth)
        print(deviceWidth)
    
       
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = 10
        
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}
