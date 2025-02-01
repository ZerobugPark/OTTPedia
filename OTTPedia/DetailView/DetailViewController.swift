//
//  DetailViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

import Kingfisher

protocol PassHiddenButtonDelegate {
    func hidebuttonTapped()
    
}


final class DetailViewController: UIViewController {
    
    
    private var detailView = DetailView()
    private var backdrops: [ImageInfo] = []
    private var posters: [ImageInfo] = []
    private var castInfo: [CastInfo] = []
    private var likeButtonStatus = false
    private var maxBackdropImageCount = 0
    private let sections = ["Synopsis", "Cast", "Poster"]
    
    var movieInfo: (info: Results, likeStatus: Bool)?
    
    var delegate: PassMovieLikeDelegate?
 
    
    let color:[UIColor] = [.red,.blue,.green,.yellow,.purple]
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.scrollView.delegate = self
        
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
        detailView.tableView.register(SynopsisTableViewCell.self, forCellReuseIdentifier: SynopsisTableViewCell.id)
        detailView.tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.id)
        detailView.tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        
        detailView.tableView.estimatedRowHeight = 100 // 오토디멘션 사용시 추정값을 잡아줘야 함
       
        
        let group = DispatchGroup()
        if let (info, likeStatus) = movieInfo {
            group.enter()
            NetworkManger.shared.callRequest(api: .getImage(id: info.id), type: GetImage.self) { value in
                self.backdrops = value.backdrops
                self.maxBackdropImageCount = self.backdrops.count
                self.posters = value.posters
                group.leave()
            } failHandler: { stauts in
                let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                self.showAPIAlet(msg: msg)
                group.leave()
            }
            group.enter()
            NetworkManger.shared.callRequest(api: .getCredit(id: info.id), type: GetCredit.self) { value in
                self.castInfo = value.cast
                group.leave()
            } failHandler: { stauts in
                let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                self.showAPIAlet(msg: msg)
                group.leave()
            }
            likeButtonStatus = likeStatus
        }
        
        group.notify(queue: .main) {
            //print("DispatchGroup Notifiy")
            self.detailView.tableView.reloadData()
       
        }
        print(#function)
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addContentScrollView()
        setPageControl()
        
        if let (info, _) = movieInfo {
            detailView.dateLabel.text = info.releaseDate + "  | "
            detailView.avgLabel.text = info.average.formatted() + "  | "
            detailView.genreLabel.text = findGenre(genres: info.genreIds)
            
            for i in 0..<detailView.imageViews.count {
                detailView.imageViews[i].isHidden = false
            }
  
            configurationNavigationController(title: info.title)
        }
        print(#function)

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
        
        if let (info, _) = movieInfo  {
            delegate?.detailViewLikeButtonTapped(id: info.id, status: likeButtonStatus)
        }
            
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
        
        if maxBackdropImageCount == 0 {
            return
        } else if maxBackdropImageCount >= 5  {
            maxBackdropImageCount = 5
        }
        
        for i in 0..<maxBackdropImageCount {
            let imageView = UIImageView()
            // 이미지를 스크롤뷰와 동일한 사이즈를 맞추기 위해, x좌표를 알아야함, h는 고정 사이즈이기 때문에, 상관 X
            let xPos = detailView.scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: detailView.scrollView.bounds.width, height: detailView.scrollView.bounds.height)
            
            
           
            let url = URL(string: Configuration.shared.secureURL + Configuration.BackdropSizes.w780.rawValue + backdrops[i].filePath)
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


//MARK: - UITableViewDelegate Delegate
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //섹션별 테이블 뷰 개수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            guard let cell = detailView.tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.id, for: indexPath) as? SynopsisTableViewCell else { return UITableViewCell() }
            
            if let (info, _) = movieInfo {
                cell.setupLabel(title: sections[indexPath.row], overView: info.overview)
            } else {
                cell.setupLabel(title: "", overView: "")
            }
            cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = detailView.tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }

            cell.setupLabel(title: sections[indexPath.section])
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.section - 1
            cell.collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
            cell.collectionView.reloadData()
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.section == 2 {
            
            guard let cell = detailView.tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
            cell.setupLabel(title: sections[indexPath.section])
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.section - 1
            cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
            cell.collectionView.reloadData()
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            return UITableViewCell()
        }

            
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        if indexPath.section == 1 {
            // 하나의 테이블셀에서 아이템을 기준으로 변경하려고 각각 화면을 구성하려고 했으나, 컬렉션뷰와 오토디멘션 문제로 구조 변경
            // 테이블 뷰 안에서 컬렉션 뷰를 만드는데, 오토디멘션으로 설정시, 컬렉션뷰에서 높이를 테이블뷰가 찾을 수가 없음
            // 기기별 동적 대응을 위해, 각 섹션으로 구분하고. 기기별 대응을 위해 섹션별 높이를 비율로 새롭게 설정함.
            return (UIScreen.main.bounds.size.width / 2.5)
        } else if indexPath.section == 2 {
            return (UIScreen.main.bounds.size.width / 1.8)
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: - CollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            return castInfo.count
        } else if collectionView.tag == 1 {
            return posters.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView.tag == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setupCast(info: castInfo[indexPath.item])
            
            return cell
            
        } else if collectionView.tag == 1 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setupPoster(info: posters[indexPath.item])
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
       
    }
    
}

extension DetailViewController: PassHiddenButtonDelegate {
    func hidebuttonTapped() {
        detailView.tableView.reloadData()
    }
}



