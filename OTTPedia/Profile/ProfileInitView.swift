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
    let nameTextField = CustomTextField()
    private let lineView = UIView()
    let infoLable = CustomLabel(boldStyle: false, fontSize: 12, italic: false)
    let startButton = CustomButton(color: ColorList.main.color)
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(circleView)
        addSubview(subImageView)
        addSubview(nameTextField)
        addSubview(lineView)
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
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(self).inset(40)
            //make.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self).inset(32)
            make.size.equalTo(1)
        }
        
        infoLable.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self).inset(40)
            make.height.equalTo(15)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(infoLable.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 8.0)
            
        }
        
   

        
    }
    
    override func configureView() {
        
        let randomImage = ImageList.shared.profileImageList.randomElement()!
        imageView.image = UIImage(named: randomImage)
        imageView.isUserInteractionEnabled = true // 뷰에도 터치 가능하게
        
        circleView.backgroundColor = ColorList.main.color
        
        subImageView.image = UIImage(systemName: "camera.fill")
        subImageView.tintColor = .white
        subImageView.contentMode = .scaleAspectFit
    
        lineView.backgroundColor = ColorList.white.color
        
        infoLable.textAlignment = .left
        infoLable.textColor = ColorList.main.color
        infoLable.text = "dsasdadadadsadadsad"
        
        startButton.setTitle("완료", for: .normal)
        
        DispatchQueue.main.async {
            self.circleView.layer.cornerRadius = self.circleView.frame.width / 2
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.subImageView.layer.cornerRadius = self.subImageView.frame.width / 2
        }
    
        self.backgroundColor = .black
        
    }

}
