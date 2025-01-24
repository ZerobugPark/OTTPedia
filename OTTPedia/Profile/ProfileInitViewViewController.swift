//
//  ProfileInitViewViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class ProfileInitViewViewController: UIViewController {
    
    private var profileInit = ProfileInitView()
    private var tempList: [String] = []
    
    
    override func loadView() {
        view = profileInit
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        configurationNavigationController()
        
        profileInit.nameTextField.delegate = self
        
        profileInit.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startButtonTapped)))
        
    }
    
    
    @objc private func startButtonTapped(_ sender: UIButton) {
        print(#function)
        let vc = ProfileInitViewViewController()
        navigationController?.pushViewController(vc, animated: true)
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

extension ProfileInitViewViewController: UITextFieldDelegate {
 
    // 입력은 되었지만 반영 X
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let minLength = 2
        let specialCharacter = ["@","#","$","%"]
        let numbers = ["0","1","2","3","4","5","6","7","8","9"]
        var msg = ""
        var status = true
        
        
        if !specialCharacter.contains(string) && !numbers.contains(string) {
            if string.isEmpty, tempList.count != 0 {
                tempList.removeLast()
                print(tempList)
            } else {
                tempList.append(string)
                print(tempList)
            }
            if tempList.count >= minLength && tempList.count <= maxLength {
                msg = "사용할 수 있는 닉네님이에요"
            } else {
                msg = "2글자 이상 10글자 미만으로 설정해주세요"
            }
        } else if specialCharacter.contains(string) {
            msg = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            status = false
        } else {
            msg = "닉네임에 숫자는 포함할 수 없어요"
            status = false
        }
                
        if status {
            profileInit.infoLable.text = msg
            status = tempList.count >= minLength && tempList.count <= maxLength //문자 카운트 비교해서 1글자 또는 10글자 초과일경우 버튼 disable
            profileInit.okButton.isEnabled = status
            return true
        } else {
            profileInit.infoLable.text = msg
            profileInit.okButton.isEnabled = status
            return false
        }
        
    }

}
