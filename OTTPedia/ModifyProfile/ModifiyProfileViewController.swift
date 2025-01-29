//
//  ModifiyProfileViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

final class ModifiyProfileViewController: UIViewController {

    private var profileModify = ProfileInitView()
    private var currentIndex = 0
    private var imageStatus = true
    
    override func loadView() {
        view = profileModify
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurationNavigationController()
        
        profileModify.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
    }
    
    
    private func configurationNavigationController() {
        
        let title = "프로필 편집"
        navigationItem.title = title
      
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.leftBarButtonItem = leftButton
        
        let buttonTitle = "저장"
        let rightButton = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(saveButtonTapped))
    
        navigationItem.rightBarButtonItem = rightButton
        
        navigationItem.backButtonTitle = ""

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            self.profileModify.imageView.layer.cornerRadius = self.profileModify.imageView.frame.width / 2
        }
        
        profileModify.okButton.isHidden = true
        
    }
    
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ProfileImageSettingViewController()
       
        // 프로필 사진을 새로 선택하고, 만약 확인을 안누르고 프로필 사진을 다시 누르게되면, 변경된 이미지가 선택되어야 함
        vc.imageIndex = imageStatus ? profileModify.randomImageIndex : currentIndex
        
        vc.changedImage = { value in
            self.profileModify.imageView.image = UIImage(named: ImageList.shared.profileImageList[value])
            self.currentIndex = value
            self.imageStatus = false // 이거 currentIndex가 바뀔 때마다 didset으로 변경해도 되지 않나?
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
