//
//  ProfileInitViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/10/25.
//

import Foundation

final class ProfileInitViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
        let okButtonTapped: Observable<String> = Observable((""))
        let textCountStatus: Observable<String?> = Observable((""))
        let char: Observable<String> = Observable((""))
        let currentText: Observable<String?> = Observable((nil))
        let selectedImage: Observable<Int> = Observable((0))
        
        //Modify Only
        let saveButtonTapped: Observable<String> = Observable((""))
    }
    
    struct Output {
        let viewDidLoad: Observable<Void> = Observable(())
        let textCountStatus: Observable<Bool> = Observable((false))
        let charStatus: Observable<(String, Bool)>  = Observable(("",false))
        let textFieldStatus: Observable<(String, Bool)>  = Observable(("",false))
        let updateImage: Observable<Int> = Observable((0))
        
        let randomImageIndex = Int.random(in: 0..<ImageList.shared.profileImageList.count)
        
        var isOk: Bool = false
        

    }
    
    
    let navigationTitle = "프로필 설정"
    let emptyString = ""

    private var infoMsg = ""
    
    //Modify Only
    var userInfo = UserInfo()
    
    var updateUserInfo: ((UserInfo) -> (Void))?
    
    init() {
        print("ProfileInitViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
  
    func transform() {
    
        input.viewDidLoad.lazyBind { [weak self] in
            self?.output.viewDidLoad.value = ()
            self?.output.updateImage.value = self!.output.randomImageIndex

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
            self?.validationString(str: str)
        }
        
        input.selectedImage.lazyBind { [weak self] index in
            self?.output.updateImage.value = index
        }
        
        
        input.saveButtonTapped.lazyBind { [weak self] str in
            self?.saveButtonTapped(id: str)
        }
        
    }
    

    
    private func checkTextCount(str: String?) {
        if let text = str {
            if text.count < 2 {
                output.textCountStatus.value = false
            } else {
                output.textCountStatus.value = true
            }
        }
    }
    
    private func validationChar(char: String) {
        
        let specialCharacter = ["@","#","$","%"]
        
        
        if specialCharacter.contains(char) {
            infoMsg = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            output.isOk = false
        } else if let _ = Int(char) {
            infoMsg = "닉네임에 숫자는 포함할 수 없어요"
            output.isOk = false
        } else {
            output.isOk = true
        }
        
        output.charStatus.value = (infoMsg, output.isOk)
        
    }
    
    private func validationString(str: String?) {
        
        let maxLength = 10
        let minLength = 2
        
        if output.isOk {
            
            guard let text = str else {
                print("nil입니다.")
                return
            }
            if text.count >= minLength && text.count <= maxLength {
                infoMsg = "사용할 수 있는 닉네님이에요"
                output.isOk = true
            } else  {
                infoMsg = "2글자 이상 10글자 미만으로 설정해주세요"
                output.isOk = false
            }
     
        
            output.textFieldStatus.value = (infoMsg, output.isOk)
        }
    }
    
    
    deinit {
        print("ProfileInitViewModel Deinit")
    }
    
    
}

// MARK: - ProfileInitViewController

extension ProfileInitViewModel {
    private func okButtonTapped(id: String) {
        ProfileUserDefaults.isEnroll = true
        ProfileUserDefaults.imageIndex = output.updateImage.value
        ProfileUserDefaults.resgisterDate = Date().formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits).locale(Locale(identifier: "ko_KR")))
        
        ProfileUserDefaults.id = id
    }
}

// MARK: - ModifyViewController
extension ProfileInitViewModel {
    private func saveButtonTapped(id: String) {
        
        userInfo.id = id
        userInfo.userImageIndex = output.updateImage.value
        updateUserInfo?(userInfo)
    }
}
