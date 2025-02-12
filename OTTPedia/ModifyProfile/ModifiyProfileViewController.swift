//
//  ModifiyProfileViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/29/25.
//

import UIKit

final class ModifiyProfileViewController: UIViewController {

    private var modifyView = ProfileInitView()
    var modifyModel = ProfileInitViewModel()
    
    
    override func loadView() {
        view = modifyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modifyView.nameTextField.delegate = self
        
        modifyView.nameTextField.becomeFirstResponder()
        
        modifyView.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        
        bindData()
        
    }
    
    private func bindData() {
        modifyModel.output.viewDidLoad.bind {[weak self] _ in
            let title = "프로필 편집"
            self?.navigationItem.title = title
          
            let leftButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(self?.cancelButtonTapped))
            
            self?.navigationItem.leftBarButtonItem = leftButton
            
            let buttonTitle = "저장"
            let rightButton = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(self?.saveButtonTapped))
            
            self?.navigationItem.rightBarButtonItem = rightButton
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
            self?.navigationItem.backButtonTitle = self?.modifyModel.emptyString
            
            self?.modifyView.okButton.isHidden = true
            
            let index = self!.modifyModel.userInfo.userImageIndex
            self?.modifyView.imageView.image = ImageList.shared.profileImageList[index]
            self?.modifyView.nameTextField.text =  self?.modifyModel.userInfo.id
            
            self?.modifyView.infoLable.text = self?.modifyModel.emptyString
            
        }
        
        modifyModel.output.updateImage.lazyBind { [weak self] index in
            self?.modifyView.imageView.image = ImageList.shared.profileImageList[index]
        }
        
        modifyModel.output.charStatus.lazyBind { [weak self] (msg, status) in
            self?.modifyView.infoLable.text = msg
            self?.modifyView.infoLable.textColor = status ? ColorList.main :  ColorList.red
        }
        
        modifyModel.output.textFieldStatus.lazyBind { [weak self] (msg, status) in
            self?.modifyView.infoLable.text = msg
            self?.modifyView.infoLable.textColor = status ? ColorList.main :  ColorList.red
            
            
            self?.navigationItem.rightBarButtonItem?.isEnabled = status
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            self.modifyView.imageView.layer.cornerRadius = self.modifyView.imageView.frame.width / 2
        }
   
    }
    
}

// MARK: - TextFieldDelegate
extension ModifiyProfileViewController: UITextFieldDelegate {
    
    // textField.text에 값이 있음
    func textFieldDidChangeSelection(_ textField: UITextField) {
        modifyModel.input.currentText.value = textField.text
    }
 
    // 입력은 되었지만 textField.text에는 아직 값이 없음
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        modifyModel.input.char.value = string
        return modifyModel.output.isOk

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

}

// MARK: - addTraget OBJ Function
extension ModifiyProfileViewController {
    @objc private func saveButtonTapped(_ sender: UIButton) {
        modifyModel.input.saveButtonTapped.value = modifyView.nameTextField.text!
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ProfileImageSettingViewController()
        
        vc.settingModel.output.currentImageIndex.value = modifyModel.userInfo.userImageIndex
        
        vc.settingModel.changedImage = { value in

            self.modifyModel.input.selectedImage.value = value
            
        }

        navigationController?.pushViewController(vc, animated: true)
        
    }
}
