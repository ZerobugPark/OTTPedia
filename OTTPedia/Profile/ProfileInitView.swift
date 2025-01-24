//
//  ProfileInitView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class ProfileInitView: BaseView {

    let imageView = CustomImageView(selected: true)
    let subImageView = CustomImageView()
    let infoLable = CustomLabel(boldStyle: false, fontSize: 14, italic: false)
    let startButton = CustomButton(color: ColorList.main.color)
    let nameTextField = UITextField()
    let profileImageList = ["profile_0", "profile_1", "profile_2", "profile_3",
                            "profile_4", "profile_5", "profile_6", "profile_7",
                            "profile_8", "profile_9", "profile_10", "profile_11"]
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(subImageView)
        addSubview(infoLable)
        addSubview(startButton)
        
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(44)
            make.centerX.equalTo(self)
            make.size.equalTo(self.snp.width).multipliedBy(1.0 / 3.0)
        }
        
        subImageView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(100)
        }
        
   

        
    }
    
    override func configureView() {
        
        let randomImage = ImageList.shared.profileImageList.randomElement()!
        imageView.image = UIImage(named: randomImage)
        
        subImageView.image = UIImage(systemName: "camera.fill")
        subImageView.contentMode = .scaleAspectFill
        subImageView.tintColor = .white
        subImageView.backgroundColor =  ColorList.main.color
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.subImageView.layer.cornerRadius = self.subImageView.frame.width / 2
        }
        
        startButton.setTitle("시작하기", for: .normal)
        
        self.backgroundColor = .black
        
    }

}
