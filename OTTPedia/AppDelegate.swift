//
//  AppDelegate.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
        //sleep은 초단위 지원, Thread.sleep는 초/밀리세컨드 단위 지원
        Thread.sleep(forTimeInterval: 2.0)  // 런치스크린 지연
            
        configurationNavigationController()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      
    }

    private func configurationNavigationController() {
        
//        let title = "OTTPedia"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
       // navigationController?.navigationBar.standardAppearance = appearance
       //navigationItem.title = title
        //navigationController?.navigationBar.tintColor = ColorList.main.color
        UINavigationBar.appearance().tintColor = ColorList.main.color
        UINavigationBar.appearance().standardAppearance = appearance

    }

}

