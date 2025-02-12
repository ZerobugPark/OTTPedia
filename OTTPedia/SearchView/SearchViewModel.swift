//
//  SearchViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/11/25.
//

import Foundation


class SearchViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
        let serachButtonTapped: Observable<String?> = Observable(nil)
        let checklikeStatus: Observable<Int> = Observable(0)
        let likeButtonTapped: Observable<(Int, Bool)> = Observable((0, false))
        let pagenationStart: Observable<[IndexPath]> = Observable(([]))
    }
    
    struct Output {
        let viewDidLoad: Observable<String?> = Observable((nil))
        let searchResult: Observable<[Results]> = Observable([])
        let noResult: Observable<Bool> = Observable(false)
        let errorMessage: Observable<String> = Observable("")
        let navigationTitle: String = "OTTPedia"
        let backButtonTitle: String = ""
        
        var likeImageStatus: Bool = false
    }
    
    
    var searchText = ""
    var recentTextInfo: ((String) -> Void)?
 
    
    private var currentPage = 1
    private var totalPage = 0
    
    private var likeMovie: [Int] = []
    
    init() {
        print("SearchViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            if (self?.searchText.isEmpty) != nil {
                self?.callRequest()
                self?.output.viewDidLoad.value = (self!.searchText)
            }
            self?.output.viewDidLoad.value = (nil)
            self?.likeMovie = ProfileUserDefaults.likeMoive
        }
        
        input.serachButtonTapped.lazyBind { [weak self] search in
            if let text = search {
                self?.searchText = text
                self?.currentPage = 1
                self?.recentTextInfo?(self!.searchText)
                self?.output.searchResult.value.removeAll()
                self?.callRequest()
            }
            
        }
        
        input.checklikeStatus.lazyBind { [weak self] index in
            self?.output.likeImageStatus = self!.checkLikeStatus(index: index)
        }
        
        input.likeButtonTapped.lazyBind { [weak self] (index, stauts) in
         
            self?.likeButtonTapped(index: index, status: stauts)
        }
        
        input.pagenationStart.lazyBind { [weak self] indexPath in
            self?.pagenation(indexPaths: indexPath)
        }
    }
    
    private func callRequest() {
        NetworkManger.shared.callRequest(api: .searchMoive(query: searchText, page: currentPage), type: Trending.self) { response in
            
            switch response {
            case .success(let value):
                self.output.searchResult.value.append(contentsOf: value.results)
                self.totalPage = value.totalPage
                self.noResult()
            case .failure(_):
                print("")
                self.output.errorMessage.value = ("Error")
                //let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
            }
        }
    }
    
    private func noResult() {
        
        if output.searchResult.value.isEmpty {
            output.noResult.value = false
        } else {
            output.noResult.value = true
        }
    }
    
    private func checkLikeStatus(index: Int) -> Bool {
        let likeStatus = likeMovie.contains(output.searchResult.value[index].id)
        return likeStatus
    }
    
    private func pagenation(indexPaths: [IndexPath]) {
        if currentPage > totalPage {
            print("맥스입니다")
            return
        } else {
            for path in indexPaths {
                if output.searchResult.value.count - 2 == path.row {
                    currentPage += 1
                    callRequest()
                }
            }
        }
    }
    
    
    deinit {
        print("SearchViewModel DeInit")
    }
    
}

// MARK: - SearchViewModel Delegate Method
extension SearchViewModel {

    func likeButtonTapped(index: Int, status: Bool) {
        
        if status {
            likeMovie.append(output.searchResult.value[index].id)
        } else { //이거 Set으로 변경해도 될거 같다.
            if let sameID = likeMovie.lastIndex(of: output.searchResult.value[index].id) {
                likeMovie.remove(at: sameID)
            }
        }
        ProfileUserDefaults.likeMoive = likeMovie
    }
    
    func detailViewLikeButtonTapped(id: Int, status: Bool) {
        //likeMovie.updateValue(status, forKey: String(id))
        //ProfileUserDefaults.likeMoive = likeMovie
        //userInfo.likeCount = likeCount()
       // mainView.collectionView.reloadData()
        
    }
    
}
