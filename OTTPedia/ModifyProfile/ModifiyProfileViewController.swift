//
//  ModifiyProfileViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

final class ModifiyProfileViewController: UIViewController {

    private var profileModify = ProfileInitView()
    private var currentIndex = 0
    
    private var infoMsg = ""
    private var isOk = true
    
    var userInfo = UserInfo()
    var updateUserInfo: ((UserInfo) -> (Void))?
    
    override func loadView() {
        view = profileModify
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileModify.nameTextField.delegate = self
        
        configurationNavigationController()
        setupUserInfo()
        currentIndex = userInfo.userImageIndex
        
        profileModify.nameTextField.becomeFirstResponder()
        
        profileModify.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
    }
    
    
    private func configurationNavigationController() {
        
        let title = "프로필 편집"
        navigationItem.title = title
      
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.leftBarButtonItem = leftButton
        
        let buttonTitle = "저장"
        let rightButton = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(saveButtonTapped))
    
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.backButtonTitle = ""

    }
    
    private func setupUserInfo() {
        // 프로필 이미지 편집이 네비게이션으로 연결되어있기 때문에, viewWill에서 셋팅 불가능
        
        profileModify.imageView.image = UIImage(named: ImageList.shared.profileImageList[userInfo.userImageIndex])
        profileModify.nameTextField.text =  userInfo.id
        
        profileModify.infoLable.text = ""
        profileModify.okButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            self.profileModify.imageView.layer.cornerRadius = self.profileModify.imageView.frame.width / 2
        }
   
    }
    
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        
        userInfo.userImageIndex = currentIndex
        userInfo.id = profileModify.nameTextField.text!
        updateUserInfo?(userInfo)
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ProfileImageSettingViewController()
       
        vc.imageIndex = currentIndex
        vc.isEdit = true
        vc.changedImage = { value in
            self.profileModify.imageView.image = UIImage(named: ImageList.shared.profileImageList[value])
            self.currentIndex = value
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

// MARK: - TextFieldDelegate
extension ModifiyProfileViewController: UITextFieldDelegate {
    
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
                profileModify.infoLable.text = infoMsg
                navigationItem.rightBarButtonItem?.isEnabled = isOk
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
            profileModify.infoLable.text = infoMsg
            navigationItem.rightBarButtonItem?.isEnabled = isOk
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
