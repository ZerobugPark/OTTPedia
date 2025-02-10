//
//  ProfileInitViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/10/25.
//

import Foundation

class ProfileInitViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
        let okButtonTapped: Observable<String> = Observable((""))
        let textCountStatus: Observable<String?> = Observable((""))
        let char: Observable<String> = Observable((""))
        let currentText: Observable<String?> = Observable((nil))
        let selectedImage: Observable<Int> = Observable((0))
    }
    
    struct Output {
        let viewDidLoad: Observable<Void> = Observable(())
        let textCountStatus: Observable<Bool> = Observable((false))
        let charStatus: Observable<(String, Bool)>  = Observable(("",false))
        let textFieldStatus: Observable<(String, Bool)>  = Observable(("",false))
        let updateImage: Observable<Int> = Observable((0))
    }
    
    
    let navigationTitle = "프로필 설정"
    let backButtonTitle = ""
    private let randomImageIndex = Int.random(in: 0..<ImageList.shared.profileImageList.count)

    var isOk = false
    var infoMsg = ""
    
    
    init() {
        print("ProfileInitViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
    
        input.viewDidLoad.lazyBind { [weak self] _ in
            //self?.output.viewDidLoad.value = ()
            self?.output.updateImage.value = self!.randomImageIndex
            
        }
        
        input.okButtonTapped.lazyBind { [weak self] name in
            self?.okButtonTapped(id: name)
        }
        
        input.textCountStatus.lazyBind { [weak self] str in
            self?.checkTextCount(str: str)
        }
        
        //문자 처리
        input.char.lazyBind { [weak self] char in
            self?.validationChar(char: char)
        }
        //문자열 처리
        input.currentText.lazyBind { [weak self] str in
            print("inputTextField")
            self?.validationString(str: str)
        }
        
        input.selectedImage.lazyBind { [weak self] index in
            self?.output.updateImage.value = index
        }
        
    }
    
    private func okButtonTapped(id: String) {
        ProfileUserDefaults.isEnroll = true
        ProfileUserDefaults.imageIndex = output.updateImage.value
        ProfileUserDefaults.resgisterDate = Date().formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits).locale(Locale(identifier: "ko_KR")))
        
        ProfileUserDefaults.id = id
    }
    
    private func checkTextCount(str: String?) {
        if let text = str {
            if text.count < 2 {
                output.textCountStatus.value = false
                //profileInit.nameTextField.becomeFirstResponder()
            } else {
                output.textCountStatus.value = true
                //view.endEditing(true)
            }
        }
    }
    
    private func validationChar(char: String) {
        
        let specialCharacter = ["@","#","$","%"]
        
        
        if specialCharacter.contains(char) {
            infoMsg = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            isOk = false
        } else if let _ = Int(char) {
            infoMsg = "닉네임에 숫자는 포함할 수 없어요"
            isOk = false
        } else {
            isOk = true
        }
        
        output.charStatus.value = (infoMsg, isOk)
        
    }
    
    private func validationString(str: String?) {
        
        let maxLength = 10
        let minLength = 2
        
        
        if isOk {
            if let text = str {
                if text.count >= minLength && text.count <= maxLength {
                    infoMsg = "사용할 수 있는 닉네님이에요"
                    isOk = true
                } else  {
                    infoMsg = "2글자 이상 10글자 미만으로 설정해주세요"
                    isOk = false
                }
            }
        
            output.textFieldStatus.value = (infoMsg, isOk)
        }
    }
    
    
    deinit {
        print("ProfileInitViewModel Deinit")
    }
    
    
}
