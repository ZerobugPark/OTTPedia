//
//  SettingViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class SettingViewController: UIViewController {

    private var settingView = SettingView()
    private var settingModel = SettingViewModel()
    
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
        settingView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
        
        settingView.tableView.estimatedRowHeight = 50
        
        settingView.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        
        
        bindData()
    }
    
    private func bindData() {
        settingModel.output.viewWillAppear.lazyBind { [weak self] msg in
            
            self?.settingView.likeStorageButton.setTitle(msg, for: .normal)
            
            self?.settingView.imageView.image = ImageList.shared.profileImageList[self!.settingModel.output.userInfo.userImageIndex]
            self?.settingView.nameLabel.text = self?.settingModel.output.userInfo.id
            self?.settingView.dateLabel.text = self?.settingModel.output.userInfo.date
            
            self?.navigationItem.title = self?.settingModel.output.navigationtitle
        }
        
        settingModel.output.showAlert.lazyBind { [weak self] (title, msg) in
           
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                
                guard let windwScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windwScene.windows.first else { return }
    
                self?.settingModel.input.resetUserDefaults.value = ()
                
                window.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
                window.makeKeyAndVisible()
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self?.present(alert,animated: true)
        }
        
    }


    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.settingView.imageView.layer.cornerRadius = self.settingView.imageView.frame.width / 2
        }
        
        settingModel.input.viewWillAppear.value = ()
    
    }
    
    
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel.output.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.setupContent(title: settingModel.output.contents[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        settingModel.input.didSelectRowAt.value = indexPath.row
//        
//        if indexPath.row == Setting.withdraw.rawValue {
//            let title = "탈퇴하기"
//            let msg = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
//            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//            
//            let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
//                
//                guard let windwScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windwScene.windows.first else { return }
//                
//                for key in UserDefaults.standard.dictionaryRepresentation().keys {
//                    UserDefaults.standard.removeObject(forKey: key.description)
//                }
//                window.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
//                window.makeKeyAndVisible()
//            }
//            
//            let cancel = UIAlertAction(title: "취소", style: .cancel)
//            
//            alert.addAction(ok)
//            alert.addAction(cancel)
//            
//            present(alert,animated: true)
//            
//        }
    }
    
    
}

// MARK: - OBJC Function
extension SettingViewController {
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ModifiyProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isModalInPresentation = true
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
       // vc.userInfo = userInfo
        
//        //vc.updateUserInfo = { info in
//            //self.userInfo.userImageIndex =  info.userImageIndex
//          //  self.userInfo.id =  info.id
//            
//            // willDisapeear에 저장할 경우 저장되는 delay가 조금 발생해서 즉각 다른 탭에서 반영이 안되는듯
//            ProfileUserDefaults.imageIndex = self.userInfo.userImageIndex
//            ProfileUserDefaults.id = self.userInfo.id
//    
//            self.settingView.imageView.image =   ImageList.shared.profileImageList[self.userInfo.userImageIndex]
//            self.settingView.nameLabel.text = self.userInfo.id
//        }
//        
//        present(nav,animated: true)

    }
}
