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
    var detailModel = DetailViewModel()

    
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
        
        
        bindData()
        detailModel.input.viewDidLoad.value = ()
    }
    
    private func bindData() {
        
        detailModel.output.viewDidLoad.lazyBind { [weak self] movieInfo in
            
            self?.navigationItem.title = movieInfo.title
            
            let rightButton = UIBarButtonItem(image: UIImage(systemName: movieInfo.likeImage), style: .plain, target: self, action: #selector(self?.likebuttonTapped))
            
            self?.navigationItem.rightBarButtonItem = rightButton
            self?.detailView.dateLabel.text = movieInfo.date
            self?.detailView.avgLabel.text = movieInfo.avg
            self?.detailView.genreLabel.text = movieInfo.genre
            
            
            for i in 0..<self!.detailView.imageViews.count {
                self?.detailView.imageViews[i].isHidden = false
            }
        }
        
        detailModel.output.finishedRequest.lazyBind { [weak self] _ in
            self?.detailView.tableView.reloadData()
        }
        
        detailModel.output.likeButtonTapped.lazyBind { [weak self] img in
           
            self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: img)
        }
        
        detailModel.output.backdropSetting.lazyBind { [weak self] _ in
            self?.addContentScrollView()
            self?.setPageControl()
        }
        
        detailModel.output.errorMessage.lazyBind { [weak self] msg in
            self?.showAPIAlet(msg: msg)
        }
        
    }
    
    deinit {
        print("DetailViewController Deinit")
    }
 
    
    
}
// MARK: - ScrollView Delegate and PageControl Function
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView.contentOffset.x : 스크롤뷰가 움직이는 실시간 좌표 값
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        
        //value 자체를 rounded를 할 경우, isNan 및 isInfinite 오류 발생
        //해결 -> 타입 자체를 Int로 먼저 바꾸지 말고, 실수형으로 바꾼 뒤 Int로 변환해서 해결(정밀하지 않아도 되니 Float로 구현)
        let index = lroundf(Float(value))
        setPageControlSelectedPage(currentPage: Int(index))
        
    }
    private func setPageControlSelectedPage(currentPage:Int) {
        detailView.pageControl.currentPage = currentPage
    }
    
    private func addContentScrollView() {
        
        for i in 0..<detailModel.output.maxBackdropImageCount {
            let imageView = UIImageView()
            // 이미지를 스크롤뷰와 동일한 사이즈를 맞추기 위해, x좌표를 알아야함, h는 고정 사이즈이기 때문에, 상관 X
            let xPos = detailView.scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: detailView.scrollView.bounds.width, height: detailView.scrollView.bounds.height)
            
 
            imageView.kf.setImage(with: detailModel.output.backdropsURL[i])
            detailView.scrollView.addSubview(imageView)
            
            // 스크롤뷰 위치 변경
            detailView.scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setPageControl() {
        detailView.pageControl.numberOfPages = detailModel.output.maxBackdropImageCount
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
            

            let title = detailModel.output.sections[indexPath.section]
            let overView = detailModel.output.overView
            cell.setupLabel(title: title, overView: overView)
            cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = detailView.tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            let title = detailModel.output.sections[indexPath.section]
            cell.setupLabel(title: title)
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.section - 1
            cell.collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
            cell.collectionView.reloadData()
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.section == 2 {
            
            guard let cell = detailView.tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
           
            let title = detailModel.output.sections[indexPath.section]
            cell.setupLabel(title: title)
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
        return detailModel.output.sections.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let deviceWidth = view.frame.width
        
        if indexPath.section == 1 {
            // 하나의 테이블셀에서 아이템을 기준으로 변경하려고 각각 화면을 구성하려고 했으나, 컬렉션뷰와 오토디멘션 문제로 구조 변경
            // 테이블 뷰 안에서 컬렉션 뷰를 만드는데, 오토디멘션으로 설정시, 컬렉션뷰에서 높이를 테이블뷰가 찾을 수가 없음
            // 기기별 동적 대응을 위해, 각 섹션으로 구분하고. 기기별 대응을 위해 섹션별 높이를 비율로 새롭게 설정함.
            
            return (deviceWidth / 2.5)
        } else if indexPath.section == 2 {
            return (deviceWidth / 1.8)
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: - CollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            return detailModel.output.castInfo.count
        } else if collectionView.tag == 1 {
            return detailModel.output.posters.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setupCast(info: detailModel.output.castInfo[indexPath.item])
            
            return cell
            
        } else if collectionView.tag == 1 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setupPoster(info: detailModel.output.posters[indexPath.item])
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
}

// MARK: - Objc Function
extension DetailViewController {
    
    @objc private func likebuttonTapped (_ sender: UIButton) {
        detailModel.input.likeButtonTapped.value = ()
        
    }
}

// MARK: - Delegate
extension DetailViewController: PassHiddenButtonDelegate {
    func hidebuttonTapped() {
        detailView.tableView.reloadData()
    }
}




