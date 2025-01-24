//
//  ProfileInitView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class ProfileInitView: BaseView {

    let imageView = CustomImageView(selected: true)
    private let circleView = UIView()
    private let subImageView = CustomImageView()
    let nameTextField = UITextField()
    let startButton = CustomButton(color: ColorList.main.color)
    let infoLable = CustomLabel(boldStyle: false, fontSize: 14, italic: false)
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(circleView)
        addSubview(subImageView)
        addSubview(nameTextField)
        addSubview(infoLable)
        addSubview(startButton)
        
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
        
   

        
    }
    
    override func configureView() {
        
        let randomImage = ImageList.shared.profileImageList.randomElement()!
        imageView.image = UIImage(named: randomImage)
        
        circleView.backgroundColor = ColorList.main.color
        
        subImageView.image = UIImage(systemName: "camera.fill")
        subImageView.tintColor = .white
        subImageView.contentMode = .scaleAspectFit
    
        
        DispatchQueue.main.async {
            self.circleView.layer.cornerRadius = self.circleView.frame.width / 2
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.subImageView.layer.cornerRadius = self.subImageView.frame.width / 2
        }
        
        startButton.setTitle("시작하기", for: .normal)
        
        self.backgroundColor = .black
        
    }

}
