//
//  DetailViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/12/25.
//

import Foundation


class DetailViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
        let likeButtonTapped: Observable<Void> = Observable(())
    }
    
    struct Output {
        let viewDidLoad: Observable<MovieInfo> = Observable((MovieInfo()))
        let finishedRequest: Observable<Void> = Observable(())
        let backdropSetting: Observable<Void> = Observable(())
        let likeButtonTapped: Observable<String> = Observable((""))
        let errorMessage: Observable<String> = Observable("")
        var maxBackdropImageCount = 0 {
            didSet {
                if maxBackdropImageCount >= 5 {
                    maxBackdropImageCount = 5
                }
            }
        }
        var backdropsURL: [URL] = []
        var posters: [ImageInfo] = []
        var castInfo: [CastInfo] = []
        var overView: String = ""
        let sections: [String] = ["Synopsis", "Cast", "Poster"]
    }
    
    struct MovieInfo {
        var date: String = ""
        var avg: String = ""
        var genre: String = ""
        var title: String = ""
        var likeImage: String = ""
    }
    
    private var backdrops: [ImageInfo] = []
    private var likeButtonStatus = false
    
    var delegate: PassMovieLikeDelegate?
    var movieInfo: (info: Results, likeStatus: Bool)?
    
    
    init() {
        print("DetailViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
    
    
    func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.movieInfoSetting()
            self?.callRequest()
        }
        
        input.likeButtonTapped.lazyBind { [weak self] _  in
            self?.likeButtonTapped()
        }
    }
    
    private func callRequest() {
        let group = DispatchGroup()
        if let (info, _) = movieInfo {
            group.enter()
            NetworkManger.shared.callRequest(api: .getImage(id: info.id), type: GetImage.self) { response in
                switch response {
                case .success(let value):
                    self.backdrops = value.backdrops
                    self.output.maxBackdropImageCount = self.backdrops.count
                    self.output.posters = value.posters
                    group.leave()
                case .failure(_):
                    // let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                    self.output.errorMessage.value = ("Error")
                    group.leave()
                }
            }
            group.enter()
            NetworkManger.shared.callRequest(api: .getCredit(id: info.id), type: GetCredit.self) { response in
                switch response {
                case .success(let value):
                    self.output.castInfo = value.cast
                    group.leave()
                case .failure(_):
                    // let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                    self.output.errorMessage.value = ("Error")
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            print("DispatchGroup Notifiy")
            self.convertImageURL()
            self.output.finishedRequest.value = ()
            
        }
    }
    
    
    private func movieInfoSetting() {
        
        var detailInfo = MovieInfo()
        
        if let (info, like) = movieInfo {
            if let releaseDate = info.releaseDate {
                detailInfo.date = releaseDate + "  | "
            } else {
                detailInfo.date = "  | "
            }
            if let average = info.average {
                detailInfo.avg = average.formatted() + "  | "
            } else {
                detailInfo.avg = "  | "
            }
            
            
            if let genre = info.genreIds {
                detailInfo.genre = findGenre(genres: genre)
            }
            
            detailInfo.title = info.title
            likeButtonStatus = like
            detailInfo.likeImage = likeButtonStatus ? "heart.fill" : "heart"
            
            output.overView = info.overview
        }
        
        
        output.viewDidLoad.value = detailInfo
    }
    
    private func findGenre(genres: [Int]) -> String {
        
        let maxCount = genres.count > 2 ? 2 : genres.count
        var genre = ""
        
        if maxCount == 0 {
            return genre
        }
        
        for i in 0..<maxCount {
            if i == maxCount - 1 {
                genre += (Configuration.Genres(rawValue: genres[i])?.genre ?? "unknown")
            } else {
                genre += (Configuration.Genres(rawValue: genres[i])?.genre ?? "unknown") + ", "
            }
        }
        return genre
    }
    
    private func convertImageURL() {
        
        for i in 0..<output.maxBackdropImageCount{
            let url = URL(string: Configuration.shared.secureURL + Configuration.BackdropSizes.w780.rawValue + backdrops[i].filePath)
            output.backdropsURL.append(url!)
        }
        output.backdropSetting.value = ()
    }
    
    
    deinit {
        print("DetailViewModel DeInit")
    }
    
    
    
}


extension DetailViewModel {
    
    private func likeButtonTapped() {
        likeButtonStatus.toggle()
        let image = likeButtonStatus ? "heart.fill" : "heart"
        
        if let (info, _) = movieInfo  {
            delegate?.detailViewLikeButtonTapped(id: info.id, status: likeButtonStatus)
        }
        output.likeButtonTapped.value = image
        
    }
}
