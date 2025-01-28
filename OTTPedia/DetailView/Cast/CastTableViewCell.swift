//
//  CastTableViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

import SnapKit

final class CastTableViewCell: BaseTableViewCell {
    
    static let id = "CastTableViewCell"
    
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
            make.bottom.equalTo(contentView).inset(16)
        }
        
    }
    
    override func configureView() {
        collectionView.backgroundColor = ColorList.black.color
        collectionView.showsHorizontalScrollIndicator = false
        
        //테이틀뷰는 해주는게 바운스를 false가 자연스럽고, 컬렉션뷰는 true가 자연스러워 보임
        //collectionView.bounces = false

    }
    
    
    func setupLabel(title: String) {
        
        sectionLabel.text = title
        

    }

    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.size.width
    
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 3
        
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 2.3
        // 60 = Label Height(20) + offset(8) + inset(16) + spacing(8)
        let objectHeight = ((UIScreen.main.bounds.size.width / 2.5) - 52) / 2
//        print(objectHeight)
//        print((UIScreen.main.bounds.size.width / 2.5))
    

        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        layout.itemSize = CGSize(width: objectWidth, height: objectHeight)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}
