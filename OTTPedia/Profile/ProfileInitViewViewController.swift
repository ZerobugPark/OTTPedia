//
//  ProfileInitViewViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class ProfileInitViewViewController: UIViewController {
    
    private var profileInit = ProfileInitView()
    
    override func loadView() {
        view = profileInit
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configurationNavigationController()
        view.backgroundColor = .black
    }
    
    private func configurationNavigationController() {
        
        let title = "프로필 설정"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = ColorList.main.color
        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
    


    
}
