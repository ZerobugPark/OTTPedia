//
//  SettingView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

final class SettingView: BaseView {

    let view = CustomView(cornerRadius: 10)
    let imageView = CustomImageView(selected: true)
    let nameLabel = CustomLabel(boldStyle: true, fontSize: 16, color:  ColorList.white.color)
    let likeStorageButton = CustomButton(cornerRadius: 8)
    let tableView = UITableView()
    let dateLabel = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.lightGray.color)
    
    
    private let chevronImage = CustomImageView()
    
    
    
    
    override func configureHierarchy() {
        addSubview(view)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(chevronImage)
        addSubview(likeStorageButton)
        addSubview(tableView)
      
        
    }
    
    override func configureLayout() {
        
        // MARK: - 프로필 레이아웃
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
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView).offset(-4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalTo(view).inset(50)
            make.height.equalTo(18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
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
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        

    }
    
    override func configureView() {
        
        imageView.image = UIImage(named: ImageList.shared.profileImageList[0])
        
        view.isUserInteractionEnabled = true // 뷰에도 터치 가능하게

        chevronImage.image = UIImage(systemName: "chevron.compact.right")
        chevronImage.tintColor = ColorList.lightGray.color
        

        tableView.bounces = false
        
        tableView.backgroundColor = ColorList.black.color
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = ColorList.lightGray.color
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      
        // 탭바에서 디스패치큐를 사용시 주의 점
        // 1. 탭바컨트롤러랑 연결된 첫 뷰는 BaseView가 실행되고 -> loadView() -> viewDidLoad() -> viewWillAppear(_:)순으로 -> DispatchQueue 순서로 동작
        // 2. 그렇기 때문에 이미지 뷰의 프레임 사이즈를 알 수 있음.
        // 3. 다른 뷰의 경우 아직까지는 뷰가 로드된 상태가 아니기 때문에, 이미지뷰의 프레임이 잡히지 않은 상태에서 디스패치큐가 실행되기 때문에, 제대로 적용이 안되는 이슈 발생
        // 4. view willAppear 또는 didAppear에서 디스패치큐를 등록으로 기능 변경
        
//        print("셋팅뷰")
//        DispatchQueue.main.async {
//          //  print("셋팅뷰 디스패치")
//            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
//        }
    }
    
   

}
