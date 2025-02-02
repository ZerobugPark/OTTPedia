//
//  TabBarController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        configureApperance()
        
        self.selectedIndex = 0
    }
    
    
    private func configureTabBarController() {
        
        let firstVC = MainViewController()
        firstVC.tabBarItem.image = UIImage(systemName: "popcorn")
        firstVC.tabBarItem.title = "CINEMA"
        firstVC.tabBarController?.selectedIndex = 0
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        // 네비게이션 컨트롤러의 색상을 안주면 nil이지만, 뷰컨트롤로간 전환시 흰색 화면이 깜빡거림처럼 발생
        // 기존 PhotoSearch에서는 흰 화면이기 때문에, 문제점을 발견하지 못했음.
        // 블랙 화면 기준으로 구현하다보니, 깜박거림 이슈가 발생했고, 원인은 네비게이션 컨트롤러의 뷰의 색상이었음.
        firstNav.view.backgroundColor = ColorList.black.color
        
        let secondVC = ComingSoonViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "film.stack")
        secondVC.tabBarItem.title = "UPCOMING"
        secondVC.tabBarController?.selectedIndex = 1
        let secondNav = UINavigationController(rootViewController: secondVC)
        secondNav.view.backgroundColor = ColorList.black.color
        
        let thridVC = SettingViewController()
        thridVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        thridVC.tabBarItem.title = "PROFILE"
        thridVC.tabBarController?.selectedIndex = 2
        let thridNav = UINavigationController(rootViewController: thridVC)
        thridNav.view.backgroundColor = ColorList.black.color
        
        setViewControllers([firstNav,secondNav, thridNav], animated: true)
        
        
    }
    
    private func configureApperance() {
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithTransparentBackground()
        tabBarApperance.selectionIndicatorTintColor = ColorList.main.color
        UITabBar.appearance().standardAppearance = tabBarApperance
    }
    
    
}
