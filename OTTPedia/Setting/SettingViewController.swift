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
