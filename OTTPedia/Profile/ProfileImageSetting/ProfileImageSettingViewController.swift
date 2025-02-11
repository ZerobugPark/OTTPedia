//
//  ProfileImageSettingViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {
    
    private var settingView = ProfileImageSettingView()
    var settingModel = ProfileImageSettingViewModel()

    var isEdit = false
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationNavigationController()
        
        settingView.collectionView.delegate = self
        settingView.collectionView.dataSource = self
        settingView.collectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.id)
        settingModel.input.viewDidLoad.value = ()
        bindData()
        
    }
    
    private func bindData() {
        settingModel.output.currentImageIndex.bind { [weak self] index in
            
            self?.settingView.imageView.image = ImageList.shared.profileImageList[index]
            //self?.navigationItem.title = self?.settingModel.navigationTitle
        }
        
        settingModel.output.imageStatus.lazyBind { [weak self] _ in
            print("outputimageStatus")
            self?.settingView.collectionView.reloadData()
        }
        settingModel.output.updateImage.lazyBind { [weak self] value  in
            self?.settingView.collectionView.reloadItems(at: [IndexPath(row: value.1, section: 0)])
            self?.settingView.collectionView.reloadItems(at: [IndexPath(row: value.0, section: 0)])
        }
    }
    
    
    private func configurationNavigationController() {
        
        let title = isEdit ? "프로필 이미지 편집" : "프로필 이미지 설정"
        navigationItem.title = title
        
    }
    
    deinit {
        print("ProfileImageSettingViewController Deinit")
    }
    
    

}

// MARK: - CollectionViewDelegate
extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageList.shared.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = settingView.collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.id, for: indexPath) as? ProfileImageSettingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data =  settingModel.profileStatus[indexPath.item]
        
        cell.imageSetup(data: data)

        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        settingModel.input.didSelected.value = indexPath.item

    }
    
    
}
