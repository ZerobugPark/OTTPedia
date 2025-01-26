//
//  MainViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class MainViewController: UIViewController {

    
    var list = ["test1", "test2"]
    
    private var mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.rowHeight = 200
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self

        configurationNavigationController()
        mainView.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        mainView.likeStorageButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    

    private func configurationNavigationController() {
        
        let title = "OTTPedia"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = ColorList.main.color
        UINavigationBar.appearance().standardAppearance = appearance
        
    }

    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        print(#function)
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        
        print(#function)
    }
    
        

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.titleLabel.text = list[indexPath.row]
        
        return UITableViewCell()
    }
    
    
}
