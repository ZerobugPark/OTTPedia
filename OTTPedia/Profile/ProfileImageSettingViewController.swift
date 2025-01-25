//
//  ProfileImageSettingViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {

    var imageIndex = 0
    var changedImage: ((Int) -> Void)?
    
    private var imageSet = ProfileImageSettingView()
    private var previousImageIndex = 0
    
    override func loadView() {
        view = imageSet

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSet.imageView.image = UIImage(named: ImageList.shared.profileImageList[imageIndex])
        
        imageSet.collectionView.delegate = self
        imageSet.collectionView.dataSource = self
        imageSet.collectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.id)
        
    }
    

}


extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageList.shared.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageSet.collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.id, for: indexPath) as? ProfileImageSettingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let isSelected = imageIndex == indexPath.item ? true : false
        cell.imageSetup(index: indexPath.item, selected: isSelected)

        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        if imageIndex != indexPath.item {
            previousImageIndex = imageIndex
            imageIndex = indexPath.item
            imageSet.imageView.image = UIImage(named: ImageList.shared.profileImageList[imageIndex])
            collectionView.reloadItems(at: [indexPath])
            collectionView.reloadItems(at: [IndexPath(row: previousImageIndex, section: indexPath.section)])
            changedImage?(imageIndex)
            
        }
    }
    
    
}
