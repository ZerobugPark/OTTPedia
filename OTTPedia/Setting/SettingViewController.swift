//
//  SettingViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class SettingViewController: UIViewController {

    private var settingView = SettingView()
    private var likeMovie: [String: Bool] = [:]
    private let contents = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    private var userInfo = UserInfo()
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
        settingView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
        
        settingView.tableView.estimatedRowHeight = 50
        
        
        configurationNavigationController()
        
        settingView.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        
    }
    
    private func configurationNavigationController() {
        
        let title = "설정"
        navigationItem.title = title
    
        
    }


    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.settingView.imageView.layer.cornerRadius = self.settingView.imageView.frame.width / 2
        }
        userInfo.userImageIndex =  ProfileUserDefaults.imageIndex
        userInfo.id =  ProfileUserDefaults.id
        userInfo.date =  ProfileUserDefaults.resgisterDate
        userInfo.likeCount = likeCount()
        
        let msg = "\(userInfo.likeCount) 개의 무비박스 보관중"
        settingView.likeStorageButton.setTitle(msg, for: .normal)
        
        
        settingView.imageView.image = ImageList.shared.profileImageList[userInfo.userImageIndex]
        settingView.nameLabel.text = userInfo.id
        settingView.dateLabel.text = userInfo.date
    }
    
    

    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ModifiyProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isModalInPresentation = true
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        vc.userInfo = userInfo
        
        vc.updateUserInfo = { info in
            self.userInfo.userImageIndex =  info.userImageIndex
            self.userInfo.id =  info.id
            
            // willDisapeear에 저장할 경우 저장되는 delay가 조금 발생해서 즉각 다른 탭에서 반영이 안되는듯
            ProfileUserDefaults.imageIndex = self.userInfo.userImageIndex
            ProfileUserDefaults.id = self.userInfo.id
    
            self.settingView.imageView.image =   ImageList.shared.profileImageList[self.userInfo.userImageIndex]
            self.settingView.nameLabel.text = self.userInfo.id
        }
        
        present(nav,animated: true)

    }
    
    private func likeCount() -> Int {
        
        //likeMovie = ProfileUserDefaults.likeMoive
        var count = 0
        for (_, value) in likeMovie {
            if value {
                count += 1
            }
        }
        return count
    }

    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.setupContent(title: contents[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == Setting.withdraw.rawValue {
            let title = "탈퇴하기"
            let msg = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                
                guard let windwScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windwScene.windows.first else { return }
                
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                window.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
                window.makeKeyAndVisible()
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            present(alert,animated: true)
            
        }
    }
    
    
}
