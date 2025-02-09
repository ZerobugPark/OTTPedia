//
//  ProfileInitViewViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class ProfileInitViewViewController: UIViewController {
    
    private var profileInit = ProfileInitView()
    private var infoMsg = ""
    private var isOk = true
    private var currentIndex = 0
    
    override func loadView() {
        view = profileInit
      
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        configurationNavigationController()
        
        profileInit.nameTextField.delegate = self
        
        profileInit.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        profileInit.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)

        currentIndex = profileInit.randomImageIndex
    
    }
    
    private func configurationNavigationController() {
        
        let title = "프로필 설정"
        navigationItem.title = title
        
        navigationItem.backButtonTitle = ""
    }
    
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ProfileImageSettingViewController()
       
        // 프로필 사진을 새로 선택한 상태에서, 확인(회원가입)을 안누르고 프로필 사진을 다시 설정할 경우, 랜덤 이미지가 아닌, 변경된 이미지가 선택될 수 있도록.
        vc.imageIndex = currentIndex
        
        vc.changedImage = { value in
            self.profileInit.imageView.image = ImageList.shared.profileImageList[value]
            self.currentIndex = value

        }
        navigationController?.pushViewController(vc, animated: true)
      
        
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        
        guard let windwScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windwScene.windows.first else { return }
        
        ProfileUserDefaults.isEnroll = true
        ProfileUserDefaults.imageIndex = currentIndex
        ProfileUserDefaults.resgisterDate = Date().formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits).locale(Locale(identifier: "ko_KR")))
        
        ProfileUserDefaults.id = profileInit.nameTextField.text!
        
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let text = profileInit.nameTextField.text {
            if text.count < 2 {
                profileInit.nameTextField.becomeFirstResponder()
            } else {
                view.endEditing(true)
            }
        }
    }
    
    
}

// MARK: - TextFieldDelegate
extension ProfileInitViewViewController: UITextFieldDelegate {
    
    // textField.text에 값이 있음
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let maxLength = 10
        let minLength = 2
        
        if isOk {
            if let text = textField.text {
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
            
        }
    }
 
    // 입력은 되었지만 textField.text에는 아직 값이 없음
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let specialCharacter = ["@","#","$","%"]
        
        let maxLength = 10
        let minLength = 2
        
        if specialCharacter.contains(string) {
            infoMsg = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            isOk = false
        } else if let _ = Int(string) {
            infoMsg = "닉네임에 숫자는 포함할 수 없어요"
            isOk = false
            
        } else {
            isOk = true
        }
        
        if !isOk {
            profileInit.infoLable.text = infoMsg
            
            if let text = textField.text {
                if text.count >= minLength && text.count <= maxLength {
                    profileInit.okButton.isEnabled = true
                } else {
                    profileInit.okButton.isEnabled = isOk
                }
            }
            return isOk
        } else {
            return isOk
        }
            
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

}
