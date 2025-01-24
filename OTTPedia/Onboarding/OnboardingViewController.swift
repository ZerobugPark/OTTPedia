//
//  OnboardingViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    private var onboard = OnboardingView()
    
    override func loadView() {
        view = onboard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .red
    }
    

 

}
