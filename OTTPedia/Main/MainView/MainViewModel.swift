//
//  MainViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/11/25.
//

import Foundation


class MainViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
        let likeStatus: Observable<Void> = Observable(())
        let updateTextList: Observable<(String?, Int?)> = Observable((nil, nil))
    }
    
    struct Output {
        let viewDidLoad: Observable<Void> = Observable(())
        let errorMessage: Observable<String> = Observable("")
        let tredingResult: Observable<[Results]> = Observable([])
        let userInfo: Observable<UserInfo> = Observable(UserInfo())
        let textList: Observable<[String]> = Observable([])
        let resarchTextStatus: Observable<Bool> = Observable(false)
    }
    
    let navigationTitle = "OTTPedia"
    let backButtonTitle = ""
    
    
    private var userInfo = UserInfo()
    
    
    
    init() {
        print("MainViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        
        
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.output.viewDidLoad.value = ()
            self?.loadData()
            self?.callRequest()
            self?.resarchTextStatus()
            
        }
        
        input.updateTextList.lazyBind { [weak self] tuple in
            self?.updateTextList(update: tuple)
        }
        
    }
    
    private func loadData() {
        userInfo.userImageIndex =  ProfileUserDefaults.imageIndex
        userInfo.id =  ProfileUserDefaults.id
        userInfo.date =  ProfileUserDefaults.resgisterDate
        
        self.output.userInfo.value = userInfo
        
        //userInfo.likeCount = likeCount()
        output.textList.value = ProfileUserDefaults.recentSearh
    }
    
    private func callRequest() {
        NetworkManger.shared.callRequest(api: .trending(), type: Trending.self) { response in
            switch response {
            case .success(let value):
                self.output.tredingResult.value = value.results
            case .failure(_):
                //let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                self.output.errorMessage.value = ("Error")
            }
        }
        
    }
    
    private func updateTextList(update: (str: String?, tag: Int?)) {
        
        
        if let str = update.str {
            
            if let sameTextIndex = output.textList.value.lastIndex(of: str) {
                output.textList.value.remove(at: sameTextIndex)
            }
            output.textList.value.insert(str, at: 0)
        } else if let tag = update.tag {
            output.textList.value.remove(at: tag)
        } else {
            output.textList.value.removeAll()
        }
       
        resarchTextStatus()
            
        ProfileUserDefaults.recentSearh =  output.textList.value
    }
    
    private func resarchTextStatus() {
        if output.textList.value.isEmpty {
            output.resarchTextStatus.value = false
        } else {
            output.resarchTextStatus.value = true
        }
    }
     
    
    deinit {
        print("MainViewModel DeInit")
    }
    
    
    
}
