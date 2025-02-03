//
//  MainViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

import SnapKit

protocol PassMovieLikeDelegate {
    func likeButtonTapped(index: Int, status: Bool)
    func detailViewLikeButtonTapped(id: Int, status: Bool)
}



final class MainViewController: UIViewController {
    
    private var mainView = MainView()
    private var trendingResult: [Results] = []
    private var userInfo = UserInfo() {
        didSet {
            let msg = "\(userInfo.likeCount) 개의 무비박스 보관중"
            mainView.likeStorageButton.setTitle(msg, for: .normal)
        }
    }
    private var likeMovie: [String: Bool] = [:]
    
    private var textList: [String] = [] {
        didSet {
            if textList.isEmpty {
                mainView.recentInfoLabel.isHidden = false
            } else {
                mainView.recentInfoLabel.isHidden = true
            }
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.recentSearchCollectionView.delegate = self
        mainView.recentSearchCollectionView.dataSource = self
        
        mainView.collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.id)
        mainView.recentSearchCollectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.id)
        
        
        
        configurationNavigationController()
        mainView.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        mainView.likeStorageButton.addTarget(self, action: #selector(likeStorageButtonTapped), for: .touchUpInside)
        mainView.removeAllButton.addTarget(self, action: #selector(removeAllButtonTapped), for: .touchUpInside)
        
        
        NetworkManger.shared.callRequest(api: .trending(), type: Trending.self) { value in
            self.trendingResult = value.results
            self.mainView.collectionView.reloadData()
        } failHandler: { stauts in
            let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
            self.showAPIAlet(msg: msg)
        }
    
    }
    
    
    private func configurationNavigationController() {
        
        let title = "OTTPedia"
        navigationItem.title = title
        navigationItem.backButtonTitle = ""
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userInfo.userImageIndex =  ProfileUserDefaults.imageIndex
        userInfo.id =  ProfileUserDefaults.id
        userInfo.date =  ProfileUserDefaults.resgisterDate
        userInfo.likeCount = likeCount()
        textList = ProfileUserDefaults.recentSearh
        
     
        mainView.imageView.image = UIImage(named:ImageList.shared.profileImageList[userInfo.userImageIndex])
        mainView.nameLabel.text = userInfo.id
        mainView.dateLabel.text = userInfo.date
        mainView.collectionView.reloadData()
        
    }
    
    private func likeCount() -> Int {
        
        likeMovie = ProfileUserDefaults.likeMoive
        var count = 0
        for (_, value) in likeMovie {
            if value {
                count += 1
            }
        }
        return count
    }
    
}



// MARK: - CollectionView Delegate

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            return textList.count
        } else if collectionView.tag == 1{
            return trendingResult.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.id, for: indexPath) as? RecentSearchCollectionViewCell else { return UICollectionViewCell() }
            
            cell.addRecnetSearchLable(text: textList[indexPath.item])
            cell.button.tag = indexPath.item
            cell.button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            return cell
            
        } else if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.id, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setupTrending(trend: trendingResult[indexPath.item])
            cell.delegate = self
            cell.likeButton.tag = indexPath.item
            
            let image = checkLikeStatus(index: indexPath.item) ? "heart.fill" : "heart"
            cell.likeButton.setImage(UIImage(systemName: image), for: .normal)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            let vc = SearchViewController()
            vc.searchText = textList[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
            
        } else if collectionView.tag == 1 {
            let vc = DetailViewController()
            vc.movieInfo = (info: trendingResult[indexPath.item], likeStatus: checkLikeStatus(index: indexPath.item))
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            
        } else { }
        
    }
    
    private func checkLikeStatus(index: Int) -> Bool {
        let likeStatus = likeMovie[String(trendingResult[index].id)] ?? false
        
        return likeStatus
    }
    
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        textList.remove(at: sender.tag)
        ProfileUserDefaults.recentSearh = self.textList
        // 갱신이 아닌 삭제가 되는거기 때문에, reloadData 사용
        mainView.recentSearchCollectionView.reloadData()
    }
}

// MARK: - CollectionViewDelegateFlowLayout Delegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    // 셀 기준으로 컬렉션 뷰의 크기를 변경할 때, 컬렉션뷰의 높이를 결정해줄 수 있는 deviceWidth의 크기를 알 수 없기 때문에 뷰컨트롤러에서 델리게이트로 사이즈 변경 해줌
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView.tag == 0 {
            
            let font = UIFont.systemFont(ofSize: 13)
            let size = textList[indexPath.item].size(withAttributes: [.font: font])
            
            // label offset 8, buttion inset 8, lable size, buttonsize = 12, spacing = 8
            let buttonSize: CGFloat = 12
            let spacing: CGFloat = 8 //(레이블과 버튼 간격)
            let inset: CGFloat = 16 // 8 + 8 (레이블과 뷰(leading) / 버튼과 뷰(trailing))
            
            let objectWidth =  size.width + buttonSize + spacing + inset
            let objectHeight = mainView.recentSearchCollectionView.bounds.height
            
            return CGSize(width: objectWidth, height: objectHeight)
            
            
        } else if collectionView.tag == 1 {
            
            var deviceWidth: Double = 0.0
            
            if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                deviceWidth = window.screen.bounds.size.width
            } else {
                deviceWidth = UIScreen.main.bounds.size.width // iOS 18.2 부터 사용 X
            }
            

            let spacing: CGFloat = 8
            let inset: CGFloat = 16
            let imageCount: CGFloat = 2
            
            let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 1.5
            let objectHeight = mainView.movieListView.frame.size.height - mainView.secondSection.frame.size.height

            return CGSize(width: objectWidth, height: objectHeight)
        } else {
            
            return CGSize(width: 0, height: 0)
        }
        
        
    }
}

// MARK: - PassMovieLikeDelegate Delegate
extension MainViewController: PassMovieLikeDelegate {

    func likeButtonTapped(index: Int, status: Bool) {
        likeMovie.updateValue(status, forKey: String(trendingResult[index].id))
        ProfileUserDefaults.likeMoive = likeMovie
        userInfo.likeCount = likeCount()
    }
    
    func detailViewLikeButtonTapped(id: Int, status: Bool) {
        likeMovie.updateValue(status, forKey: String(id))
        ProfileUserDefaults.likeMoive = likeMovie
        userInfo.likeCount = likeCount()
        mainView.collectionView.reloadData()
        
    }
    
}


// MARK: - OBJC Funcfion
extension MainViewController {
    
    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ModifiyProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isModalInPresentation = true // 내려가기 방지
        //nav.modalPresentationStyle = .pageSheet // 아마 default가 pageSheet이기 때문에 적용안해도 상관없을 듯
        
        //sheetPresentationController
        // 1. 뷰컨트롤러 연결시, pageSheet/formSheet 처럼 화면을 덮지 않아야 가능하다.
        // 2. sheetPresentationController자체가 화면 분활 처럼 뒤에 화면을 보이게 할 수도 있는 기능인데, Full Screen처럼 화면을 다 덮으면 굳이 쓸 이유가 없어 보임
        // 3.네비게이션 컨트롤러에도 적용이 가능하다, 이때, vc의 modalPresentationStyle은 상관없다.
        // 4.아마도, vc에서 적용하더라고 화면전환 방식은 nav에서 새롭게 기본값으로 변하기 때문인거 같다.
        // 5. 반대로 isModalInPresentation은 vc에서도 적용해도 동일하게 nav에서도 적용이 된다.
        
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()] // pageSheet처럼 보이게 하기 위해
            sheet.prefersGrabberVisible = true // 상단에 회색같은 막대기바 추가
        }
        
        
        vc.userInfo = userInfo
        
        vc.updateUserInfo = { info in
            self.userInfo.userImageIndex =  info.userImageIndex
            self.userInfo.id =  info.id
            
            ProfileUserDefaults.imageIndex = self.userInfo.userImageIndex
            ProfileUserDefaults.id = self.userInfo.id
            
            self.mainView.imageView.image = UIImage(named: ImageList.shared.profileImageList[self.userInfo.userImageIndex])
            self.mainView.nameLabel.text = self.userInfo.id
            self.mainView.dateLabel.text = self.userInfo.date
            
        }
        
        present(nav,animated: true)
        
    }
    
    @objc private func likeStorageButtonTapped(_ sender: UIButton) {
        
        print(#function)
    }
    
    @objc private func removeAllButtonTapped(_ sender: UIButton) {
        textList.removeAll()
        self.mainView.recentSearchCollectionView.reloadData()
    }
    
    @objc private func searchButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController()
        
        vc.textInfo = { text in
            
            if let sameTextIndex = self.textList.lastIndex(of: text) {
                self.textList.remove(at: sameTextIndex)
            }
            self.textList.insert(text, at: 0)
            self.mainView.recentSearchCollectionView.reloadData()
            ProfileUserDefaults.recentSearh = self.textList
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
