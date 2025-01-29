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
    private var imageStatus = true
    
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
        navigationItem.title = title
    }
    
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ProfileImageSettingViewController()
       
        // 프로필 사진을 새로 선택하고, 만약 확인을 안누르고 프로필 사진을 다시 누르게되면, 변경된 이미지가 선택되어야 함
        vc.imageIndex = imageStatus ? profileInit.randomImageIndex : currentIndex
        
        vc.changedImage = { value in
            self.profileInit.imageView.image = UIImage(named: ImageList.shared.profileImageList[value])
            self.currentIndex = value
            self.imageStatus = false // 이거 currentIndex가 바뀔 때마다 didset으로 변경해도 되지 않나?
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        
        guard let windwScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windwScene.windows.first else { return }
        
        ProfileUserDefaults.imageIndex = currentIndex
        
        window.rootViewController = UINavigationController(rootViewController: TabBarController())
        window.makeKeyAndVisible()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let text = profileInit.nameTextField.text {
            if text.isEmpty {
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
        
        if !isOk { // 이것도 didset 가능할 듯 해보이긴 하네
            profileInit.infoLable.text = infoMsg
            profileInit.okButton.isEnabled = isOk
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
