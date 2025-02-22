//
//  ProfileInitViewViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/24/25.
//

import UIKit

final class ProfileInitViewViewController: UIViewController {
    
    private var profileInit = ProfileInitView()
    private var profileModel = ProfileInitViewModel()
    
    private var infoMsg = ""
    private var isOk = true
    private var currentIndex = 0
    
    override func loadView() {
        view = profileInit
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        profileInit.nameTextField.delegate = self
        
        bindData()
        
        profileModel.input.viewDidLoad.value = ()
        
        addTarget()
        
    }
    
    private func bindData() {
        profileModel.output.viewDidLoad.bind { [weak self] _ in
            self?.navigationItem.title = self?.profileModel.output.navigationTitle
            self?.navigationItem.backButtonTitle =  self?.profileModel.output.emptyString
            let index = self!.profileModel.output.randomImageIndex
            self?.profileInit.imageView.image = ImageList.shared.profileImageList[index]

        }
        
        profileModel.output.updateImage.lazyBind { [weak self] index in
            self?.profileInit.imageView.image = ImageList.shared.profileImageList[index]
        }
        
        profileModel.output.textCountStatus.lazyBind { [weak self] status in
            if status {
                self?.view.endEditing(true)
            } else {
                self?.profileInit.nameTextField.becomeFirstResponder()
            }
        }
        
        profileModel.output.charStatus.lazyBind { [weak self] (msg, status) in
            self?.profileInit.infoLable.text = msg
            self?.profileInit.infoLable.textColor = status ? ColorList.main :  ColorList.red
            
        }
        
        profileModel.output.textFieldStatus.lazyBind { [weak self] (msg, status) in
            self?.profileInit.infoLable.text = msg
            self?.profileInit.infoLable.textColor = status ? ColorList.main :  ColorList.red
            
            
            self?.profileInit.okButton.isEnabled = status
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        profileModel.input.textCountStatus.value = profileInit.nameTextField.text
   
    }
    
    deinit {
        print("ProfileInitViewViewController Deinit")
    }
    
    
}

// MARK: - TextFieldDelegate
extension ProfileInitViewViewController: UITextFieldDelegate {
    
    // textField.text에 값이 있음
    func textFieldDidChangeSelection(_ textField: UITextField) {
        profileModel.input.currentText.value = textField.text

    }
    
    // 입력은 되었지만 textField.text에는 아직 값이 없음
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        profileModel.input.char.value = string
        return profileModel.output.isOk
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

// MARK: - ADD Target

extension ProfileInitViewViewController {
    
    private func addTarget() {
        profileInit.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        profileInit.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ProfileImageSettingViewController()
        
        // 프로필 사진을 새로 선택한 상태에서, 확인(회원가입)을 안누르고 프로필 사진을 다시 설정할 경우, 랜덤 이미지가 아닌, 변경된 이미지가 선택될 수 있도록.
        
        vc.settingModel.output.currentImageIndex.value = profileModel.output.updateImage.value
        
        vc.settingModel.changedImage = { value in

            self.profileModel.input.selectedImage.value = value
            
        }
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        
        guard let windwScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windwScene.windows.first else { return }
        
        profileModel.input.okButtonTapped.value = profileInit.nameTextField.text!
 
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
        
    }
}
