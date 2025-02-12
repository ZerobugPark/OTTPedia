//
//  SettingViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/12/25.
//

import Foundation


final class SettingViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    enum Setting: Int {
        case FAQ = 0
        case inquiry
        case alarm
        case withdraw
        
    }

    struct Input {
        let viewWillAppear: Observable<Void> = Observable(())
        let didSelectRowAt: Observable<Int?> = Observable(nil)
        let resetUserDefaults: Observable<Void> = Observable(())
    }
    
    struct Output {
        let viewWillAppear: Observable<String> = Observable((""))
        let showAlert: Observable<(String,String)> = Observable(("",""))
        
        let navigationtitle = "설정"
        let contents = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
        
        
        var userInfo = UserInfo()
    }
    
    
    private var likeMovie: [Int] = []
    
    
    init() {
        print("SettingViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
  
    
    func transform() {
        input.viewWillAppear.lazyBind { [weak self] _ in
            self?.loadData()
        }
        
        input.didSelectRowAt.lazyBind { [weak self] idx in
            self?.didSelect(index: idx)
        }
        
        input.resetUserDefaults.lazyBind { [weak self] _ in
            self?.resetUserDefatuls()
        }
    }
    
    
    private func loadData() {
        output.userInfo.userImageIndex =  ProfileUserDefaults.imageIndex
        output.userInfo.id =  ProfileUserDefaults.id
        output.userInfo.date =  ProfileUserDefaults.resgisterDate
        
        let likeCountString = likeCount()
        
        self.output.viewWillAppear.value = likeCountString
    }
 
    private func likeCount() -> String {
        
        likeMovie = ProfileUserDefaults.likeMoive
        let str = "\(likeMovie.count) 개의 무비박스 보관중"
        
        return str
        
    }
    
    private func didSelect(index: Int?) {
        
        guard let index = index else {
            print("올바르지 않은 인덱스입니다.")
            return
        }
        
        switch index {
        case Setting.FAQ.rawValue:
            print("error")
        case Setting.inquiry.rawValue:
            print("error")
        case Setting.alarm.rawValue:
            print("error")
        case Setting.withdraw.rawValue:
            let title = "탈퇴하기"
            let msg = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
            output.showAlert.value = (title, msg)
            
        default:
            print("error")
        }
        
    }
    
    private func resetUserDefatuls() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
            print(key)
        }
    }
    
    
    
}
