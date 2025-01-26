//
//  MainView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class MainView: BaseView {
    
    let view = CustomView()
    let imageView = CustomImageView(selected: true)
    let nameLable = CustomLabel(boldStyle: true, fontSize: 16, color:  ColorList.white.color)
    let likeStorageButton = CustomButton()
    let tableView = UITableView()
 
    
    private let dateLable = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray.color)
    private let chevronImage = CustomImageView()
    
    override func configureHierarchy() {
        addSubview(view)
        view.addSubview(imageView)
        view.addSubview(nameLable)
        view.addSubview(dateLable)
        view.addSubview(chevronImage)
        addSubview(likeStorageButton)
        addSubview(tableView)
        
        
    }
    
    override func configureLayout() {
        
        view.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 3.5)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(8)
            make.leading.equalTo(view).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(1.0 / 6.5)
        }
        
        nameLable.snp.makeConstraints { make in
            make.centerY.equalTo(imageView).offset(-4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalTo(view).inset(50)
            make.height.equalTo(18)
        }
        
        dateLable.snp.makeConstraints { make in
            make.top.equalTo(nameLable.snp.bottom).offset(2)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalTo(view).inset(50)
            make.height.equalTo(14)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.trailing.equalTo(view).inset(16)
            make.size.equalTo(imageView.snp.width).multipliedBy(1.0 / 2.5)
        }
        
        likeStorageButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(8)
            make.bottom.equalTo(view).inset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self).inset(16)
            make.bottom.equalTo(self)
        }
    }
    
    override func configureView() {
        
        
        imageView.image = UIImage(named: ImageList.shared.profileImageList[0])
        
        view.isUserInteractionEnabled = true // 뷰에도 터치 가능하게

        nameLable.text = "안녕하세요안녕하세요"

        dateLable.text = "25.01.23 가입"

        chevronImage.image = UIImage(systemName: "chevron.compact.right")
        chevronImage.tintColor = ColorList.lightGray.color
        
        likeStorageButton.setTitle("18 개의 무비박스 보관중", for: .normal)
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            
        }
        
        
    }
}
