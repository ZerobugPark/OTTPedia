//
//  ProfileImageSettingView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class ProfileImageSettingView: BaseView {
    
    
    let imageView = CustomImageView(selected: true)
    private let circleView = UIView()
    private let subImageView = CustomImageView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(circleView)
        addSubview(subImageView)
        addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(44)
            make.centerX.equalTo(self)
            make.size.equalTo(self.snp.width).multipliedBy(1.0 / 3.0)
        }
        
        circleView.snp.makeConstraints { make in
            let positionX = imageView.frame.size.width / 1.5
            let positionY = imageView.frame.size.height / 1.5
            make.trailing.equalTo(imageView).inset(positionX)
            make.bottom.equalTo(imageView).inset(positionY)
            make.size.equalTo(imageView.snp.width).multipliedBy(1.0 / 3.5)
        }
        
        subImageView.snp.makeConstraints { make in
            make.center.equalTo(circleView)
            make.size.equalTo(circleView.snp.width).multipliedBy(1.0 / 1.5)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(self)
            //make.height.equalTo(imageView.snp.width).multipliedBy(2.0)
        }
    
        
        
    }
    
    override func configureView() {
        
        circleView.backgroundColor = ColorList.main.color
        
        subImageView.image = UIImage(systemName: "camera.fill")
        subImageView.tintColor = .white
        subImageView.contentMode = .scaleAspectFit
        
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.circleView.layer.cornerRadius = self.circleView.frame.width / 2
            self.subImageView.layer.cornerRadius = self.subImageView.frame.width / 2
        }
        
        self.backgroundColor = .black
        collectionView.backgroundColor = .black
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 4
        
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 4
      
        print(objectWidth)
        print(deviceWidth)
    
        //이건 정리좀 후딱해야겠다.
        layout.minimumInteritemSpacing = spacing
        
        layout.itemSize = CGSize(width: objectWidth, height: objectWidth)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        layout.scrollDirection = .vertical
        
        return layout
    }
}

