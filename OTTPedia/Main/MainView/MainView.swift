//
//  MainView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

import SnapKit

final class MainView: BaseView {
    
    let view = CustomView(cornerRadius: 10)
    let imageView = CustomImageView(selected: true)
    let nameLabel = CustomLabel(boldStyle: true, fontSize: 16, color:  ColorList.white)
    let dateLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray)
    let likeStorageButton = CustomButton(cornerRadius: 8)
    let removeAllButton = UIButton()
    let recentInfoLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray)
    let movieListView = UIView()
    let secondSection = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white)

    private let firstSection = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white)
    private let stackView = UIStackView()
    private let recentSearchView = UIView()
 
    private let chevronImage = CustomImageView()
        
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var recentSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
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
        recentSearchView.addSubview(recentSearchCollectionView)
        recentSearchView.addSubview(recentInfoLabel)
        
        movieListView.addSubview(secondSection)
        movieListView.addSubview(collectionView)
        
        
    }
    
    override func configureLayout() {
        
        // MARK: - 프로필 레이아웃
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
        // MARK: - 최근 검색어 레이아웃
        recentSearchView.snp.makeConstraints { make in
            make.top.equalTo(stackView)
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
        
        recentSearchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstSection.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(recentSearchView).inset(4)
        }
        
        // MARK: - 오늘의 영화 레이아웃
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
        
        recentSearchView.backgroundColor = ColorList.black
        movieListView.backgroundColor = ColorList.black
        
        recentSearchCollectionView.backgroundColor = ColorList.black
        recentSearchCollectionView.showsHorizontalScrollIndicator = false
        recentSearchCollectionView.tag = 0
        
        collectionView.backgroundColor = ColorList.black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.tag = 1

        
        view.isUserInteractionEnabled = true // 뷰에도 터치 가능하게

        chevronImage.image = UIImage(systemName: "chevron.compact.right")
        chevronImage.tintColor = ColorList.lightGray
    
        
        stackView.axis = .vertical
        stackView.spacing = 4

        let titleSection = ["최근검색어", "오늘의 영화"]
        firstSection.text = titleSection[0]
        secondSection.text = titleSection[1]
        
        let text = "최근 검색어 내역이 없습니다."
        recentInfoLabel.text = text
        
        let buttonTitle = "전체 삭제"
        removeAllButton.setTitle(buttonTitle, for: .normal)
        removeAllButton.setTitleColor(ColorList.main, for: .normal)
        removeAllButton.titleLabel?.font = .systemFont(ofSize: 12)
        
        //print("메인뷰")
        DispatchQueue.main.async {
            //print("메인뷰 디스패치")
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
       
        let inset: CGFloat = 16
        let spacing: CGFloat = 8
        
        layout.minimumLineSpacing = spacing
        
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}
