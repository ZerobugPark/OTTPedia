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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

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
        
        let deviceWidth = UIScreen.main.bounds.size.width
    
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 4
        
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 3.5
        // 60 = Label Height(20) + offset(8) + inset(16) + inset(8)
        let objectHeight = ((UIScreen.main.bounds.size.width / 1.8) - 52)
//        print(objectHeight)
//        print((UIScreen.main.bounds.size.width / 2.5))
    
        layout.minimumLineSpacing = spacing
        
        layout.itemSize = CGSize(width: objectWidth, height: objectHeight)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}

