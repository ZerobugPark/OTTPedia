//
//  OnboardingViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class OnboardingViewController: UIViewController {

    
    private var onboard = OnboardingView()
    
    override func loadView() {
        view = onboard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        onboard.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    

    @objc private func startButtonTapped(_ sender: UIButton) {
        let vc = ProfileInitViewViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
 

}
