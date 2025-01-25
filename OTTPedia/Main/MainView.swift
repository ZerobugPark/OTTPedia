//
//  MainView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class MainView: BaseView {
    
    let imageView = CustomImageView(selected: true)
    let nameLable = CustomLabel(boldStyle: true, fontSize: 16, italic: false)
    let likeStorageButton = CustomButton()
    
    private let view = CustomView()
    private let dateLable = CustomLabel(boldStyle: false, fontSize: 12, italic: false)
    private let chevronImage = CustomImageView() // //chevron.right
    
    override func configureHierarchy() {
        addSubview(view)
        view.addSubview(imageView)
        addSubview(nameLable)
        addSubview(dateLable)
        addSubview(chevronImage)
        
        
    }
    
    override func configureLayout() {
        
        view.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 3.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(1.0 / 5.5)
        }
        
    }
    
    override func configureView() {
        
        
        imageView.image = UIImage(named: ImageList.shared.profileImageList[0])
        
        
        view.isUserInteractionEnabled = true // 뷰에도 터치 가능하게
        //
        //        circleView.backgroundColor = ColorList.main.color
        //
        //        subImageView.image = UIImage(systemName: "camera.fill")
        //        subImageView.tintColor = .white
        //        subImageView.contentMode = .scaleAspectFit
        //
        //        lineView.backgroundColor = ColorList.white.color
        //
        //        infoLable.textAlignment = .left
        //        infoLable.textColor = ColorList.main.color
        //        infoLable.text = "2글자 이상 10글자 미만으로 설정해주세요"
        //
        //        okButton.setTitle("완료", for: .normal)
        //        okButton.isEnabled = false
        
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            
        }
        
        
    }
}
