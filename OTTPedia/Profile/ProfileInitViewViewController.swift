//
//  ProfileInitViewViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class ProfileInitViewViewController: UIViewController {
    
    private var profileInit = ProfileInitView()
 //   private var tempList: [String] = []
    var infoMsg = ""
    var isOk = true
    
    override func loadView() {
        view = profileInit
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        configurationNavigationController()
        
        profileInit.nameTextField.delegate = self
        
        profileInit.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        profileInit.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
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
    
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        print(#function)
        let vc = ProfileImageSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    
    
    
}

extension ProfileInitViewViewController: UITextFieldDelegate {
    
    
    // 텍스트필드.text에 값이 있음
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let maxLength = 10
        let minLength = 2
        
        if isOk {
            if let text = textField.text, text.count != 0 {
                if text.count >= minLength && text.count <= maxLength {
                    infoMsg = "사용할 수 있는 닉네님이에요"
                    isOk = true
                } else {
                    infoMsg = "2글자 이상 10글자 미만으로 설정해주세요"
                    isOk = false
                }
                profileInit.infoLable.text = infoMsg
                profileInit.okButton.isEnabled = isOk
            }
            
        } else {
         
        }
        
    }
 
    // 입력은 되었지만 텍스트필드.text에는 아직 값이 없음
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(#function)
        let specialCharacter = ["@","#","$","%"]
        let numbers = ["0","1","2","3","4","5","6","7","8","9"]
        
        
        if specialCharacter.contains(string) {
            infoMsg = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            isOk = false
        } else if numbers.contains(string) {
            infoMsg = "닉네임에 숫자는 포함할 수 없어요"
            isOk = false
        } else {
            isOk = true
        }
        
        if !isOk {
            profileInit.infoLable.text = infoMsg
            profileInit.okButton.isEnabled = isOk
            return isOk
        } else {
            return isOk
        }
            
    }


}
