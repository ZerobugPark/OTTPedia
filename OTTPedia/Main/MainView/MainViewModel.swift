//
//  MainViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/11/25.
//

import Foundation


final class MainViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    struct Input {
        let viewWillAppear: Observable<Void> = Observable(())
        let likeStatus: Observable<Void> = Observable(())
        let updateTextList: Observable<(String?, Int?)> = Observable((nil, nil))
        let checklikeStatus: Observable<Int> = Observable(0)
        let likeButtonTapped: Observable<(Int, Bool)> = Observable((0, false))
        let likeUpdate: Observable<(Int, Bool)> = Observable((0, false))
        let saveData: Observable<UserInfo> = Observable(UserInfo())
    }
    
    struct Output {
        let viewWillAppear: Observable<Void> = Observable(())
        let errorMessage: Observable<String> = Observable("")
        let tredingResult: Observable<[Results]> = Observable([])
        let userInfo: Observable<UserInfo> = Observable(UserInfo())
        let textList: Observable<[String]> = Observable([])
        let resarchTextStatus: Observable<Bool> = Observable(false)
        let likeMovieCountMessage: Observable<String> = Observable("")
        let navigationTitle: String = "OTTPedia"
        let backButtonTitle: String = ""
        
        var likeImageStatus: Bool = false
        
    }
    

    
    private var likeMovie: [Int] = []
    private var userInfo = UserInfo()
    
    
    init() {
        print("MainViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        
        
        input.viewWillAppear.lazyBind { [weak self] _ in
            self?.output.viewWillAppear.value = ()
            self?.loadData()
            self?.callRequest()
            self?.resarchTextStatus()
            
        }
        
        input.updateTextList.lazyBind { [weak self] tuple in
            self?.updateTextList(update: tuple)
        }
        
        input.checklikeStatus.lazyBind { [weak self] index in
            self?.output.likeImageStatus = self!.checkLikeStatus(index: index)
        }
        
        input.likeButtonTapped.lazyBind { [weak self] (index, status) in
            self?.likeButtonTapped(index: index, status: status)
        }
        
        input.likeUpdate.lazyBind { [weak self] (id, status) in
            self?.likeUpdate(id: id, status: status)
        }
        
        input.saveData.lazyBind { [weak self] info in
            self?.saveData(info: info)
        }
        
    }
    
    private func loadData() {
        userInfo.userImageIndex =  ProfileUserDefaults.imageIndex
        userInfo.id =  ProfileUserDefaults.id
        userInfo.date =  ProfileUserDefaults.resgisterDate
        
        userInfo.likeCount = likeCount()
        output.textList.value = ProfileUserDefaults.recentSearh
        
        self.output.userInfo.value = userInfo
    }
    
    private func callRequest() {
        NetworkManger.shared.callRequest(api: .trending(), type: Trending.self) { response in
            switch response {
            case .success(let value):
                self.output.tredingResult.value = value.results
            case .failure(_):
                //let msg = ApiError.shared.apiErrorDoCatch(apiStatus: status)
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
    
    private func likeCount() -> Int {
        
        likeMovie = ProfileUserDefaults.likeMoive
        self.output.likeMovieCountMessage.value = "\(likeMovie.count) 개의 무비박스 보관중"
        return likeMovie.count
        
    }
    
    private func checkLikeStatus(index: Int) -> Bool {
        let likeStatus = likeMovie.contains(output.tredingResult.value[index].id)
        return likeStatus
    }
    
    private func saveData(info: UserInfo) {
        ProfileUserDefaults.imageIndex = info.userImageIndex
        ProfileUserDefaults.id = info.id
        output.userInfo.value = info
    }
    
    deinit {
        print("MainViewModel DeInit")
    }
    
    
    
}



// MARK: - MainViewController Delegate Method
extension MainViewModel {

    func likeButtonTapped(index: Int, status: Bool) {
        
        if status {
            likeMovie.append(output.tredingResult.value[index].id)
        } else {
            //Keep
//            var setArray: Set = Set(likeMovie)
//            setArray.remove(output.tredingResult.value[index].id)
//            likeMovie = Array(setArray)
            
            //뭐가 더 나을 까?
            if let sameID = likeMovie.lastIndex(of: output.tredingResult.value[index].id) {
                likeMovie.remove(at: sameID)
            }
        }
        ProfileUserDefaults.likeMoive = likeMovie
        userInfo.likeCount = likeCount()

    }
    
    func likeUpdate(id: Int, status: Bool) {
        if status {
            likeMovie.append(id)
        } else {
            if let sameID = likeMovie.lastIndex(of: id) {
                likeMovie.remove(at: sameID)
            }
        }
        ProfileUserDefaults.likeMoive = likeMovie
        userInfo.likeCount = likeCount()
        
    }
    
}
