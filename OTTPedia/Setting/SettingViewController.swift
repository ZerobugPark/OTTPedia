//
//  SettingViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class SettingViewController: UIViewController {

    private var settingView = SettingView()
    
    private let contents = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
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
    }

    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ModifiyProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isModalInPresentation = true // 내려가기 방지
        //nav.modalPresentationStyle = .pageSheet // 아마 default가 pageSheet이기 때문에 적용안해도 상관없을 듯
        
        //sheetPresentationController
        // 1. 뷰컨트롤러 연결시, pageSheet/formSheet 처럼 화면을 덮지 않아야 가능하다.
        // 2. sheetPresentationController자체가 화면 분활 처럼 뒤에 화면을 보이게 할 수도 있는 기능인데, Full Screen처럼 화면을 다 덮으면 굳이 쓸 이유가 없어 보임
        // 3.네비게이션 컨트롤러에도 적용이 가능하다, 이때, vc의 modalPresentationStyle은 상관없다.
        // 4.아마도, vc에서 적용하더라고 화면전환 방식은 nav에서 새롭게 기본값으로 변하기 때문인거 같다.
        // 5. 반대로 isModalInPresentation은 vc에서도 적용해도 동일하게 nav에서도 적용이 된다.
        
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()] // pageSheet처럼 보이게 하기 위해
            sheet.prefersGrabberVisible = true // 상단에 회색같은 막대기바 추가
        }
        
        present(nav,animated: true)

    }
    

    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.setupContent(title: contents[indexPath.row])
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
}
