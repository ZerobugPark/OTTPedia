//
//  PosterTableViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

import SnapKit

final class PosterTableViewCell: BaseTableViewCell {

    static let id = "PosterTableViewCell"
    
    private let sectionLabel = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white.color)
  
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())


    override func configureHierarchy() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(8)
        }
        
    }
    
    override func configureView() {
        collectionView.backgroundColor = ColorList.black.color
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    func setupLabel(title: String) {
        sectionLabel.text = title
    }

    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        var deviceWidth: Double = 0.0
        
        // View에서 불러올 수 있지만, View에서 불러오려면, viewcontroller에서 작업 처리해야함
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            deviceWidth = window.screen.bounds.size.width
        } else {
            deviceWidth = UIScreen.main.bounds.size.width // iOS 18.2 부터 사용 X
        }
        
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 4
        
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 3.5
        // 52 = Label Height(20) + offset(8) + inset(16) + inset(8)
        // 포스터 셀의 높이는 UIScreen.main.bounds.size.width / 1.8
        let objectHeight = ((deviceWidth / 1.8) - 52)
        
        layout.minimumLineSpacing = spacing
        
        layout.itemSize = CGSize(width: objectWidth, height: objectHeight)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}

