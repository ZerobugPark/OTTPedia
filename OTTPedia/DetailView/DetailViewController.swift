//
//  DetailViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

import Kingfisher

final class DetailViewController: UIViewController {
    
    
    private var detailView = DetailView()
    private var backdrops: [Imageinfo] = []
    private var posters: [Imageinfo] = []
    private var likeButtonStatus = false
    private let maxBackdropImageCount = 5
    
    var movieInfo: (id: Int, date: String, avg: Double, genreIds: [Int], title: String,likeStatus: Bool)?
    
    var idAndLikeStatus:(Int, Bool)?
    
    let color:[UIColor] = [.red,.blue,.green,.yellow,.purple]
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.scrollView.delegate = self
        
        
        if let (id, _, _, _, _, _) = movieInfo {
            NetworkManger.shared.callRequest(api: .getImage(id: id), type: GetImage.self) { value in
                self.backdrops = value.backdrops
                self.posters = value.posters
            } failHandler: {
                print()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addContentScrollView()
        setPageControl()
        
        if let (_, date, avg, genres, title, likeStatus) = movieInfo {
            detailView.dateLabel.text = date + "  |"
            detailView.avgLabel.text = avg.formatted() + "  |"
            detailView.genreLabel.text = findGenre(genres: genres)
            
            for i in 0..<detailView.imageViews.count {
                detailView.imageViews[i].isHidden = false
            }
            likeButtonStatus = likeStatus
            configurationNavigationController(title: title)
        }

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
    
    
    private func configurationNavigationController(title: String) {
        
        navigationItem.title = title
        
        let image = likeButtonStatus ? "heart.fill" : "heart"
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: image), style: .plain, target: self, action: #selector(likebuttonTapped))
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func likebuttonTapped (_ sender: UIButton) {
        likeButtonStatus.toggle()
        let image = likeButtonStatus ? "heart.fill" : "heart"
        let rightButton = UIImage(systemName: image)
            
        navigationItem.rightBarButtonItem?.image = rightButton
    }
    
    
    
}
// MARK: - ScrollView Delegate and PageControl Function
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView.contentOffset.x : 스크롤뷰가 움직이는 실시간 좌표 값
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        // print(scrollView.contentOffset.x)
        
        //value 자체를 rounded를 할 경우, isNan 및 isInfinite 오류 발생
        //해결 -> 타입 자체를 Int로 먼저 바꾸지 말고, 실수형으로 바꾼 뒤 Int로 변환해서 해결(정밀하지 않아도 되니 Float로 구현)
        let index = lroundf(Float(value))
        setPageControlSelectedPage(currentPage: Int(index))
        
    }
    private func setPageControlSelectedPage(currentPage:Int) {
        detailView.pageControl.currentPage = currentPage
    }
    
    private func addContentScrollView() {
        for i in 0..<maxBackdropImageCount {
            let imageView = UIImageView()
            // 이미지를 스크롤뷰와 동일한 사이즈를 맞추기 위해, x좌표를 알아야함, h는 고정 사이즈이기 때문에, 상관 X
            let xPos = detailView.scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: detailView.scrollView.bounds.width, height: detailView.scrollView.bounds.height)
            
            let url = URL(string: Configuration.shared.secureURL + Configuration.PosterSizes.w780.rawValue + backdrops[i].filePath)
            imageView.kf.setImage(with: url)
            detailView.scrollView.addSubview(imageView)
            // 스크롤뷰 위치 변경
            detailView.scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setPageControl() {
        detailView.pageControl.numberOfPages = maxBackdropImageCount
    }
}




