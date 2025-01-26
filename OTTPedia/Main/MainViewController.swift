//
//  MainViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class MainViewController: UIViewController {

    
    var list = ["최근검색어", "오늘의 영화"]
    
    private var mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.id)


        configurationNavigationController()
        mainView.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        mainView.likeStorageButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    

    private func configurationNavigationController() {
        
        let title = "OTTPedia"
        navigationItem.title = title    
    }

    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        print(#function)
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        
        print(#function)
    }
    
        

}




extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.id, for: indexPath) as! MovieListCollectionViewCell
        
     //   let data = detailList[collectionView.tag][indexPath.item]
        
       // let url = URL(string: data.urls.thumb)
        //cell.posterImageView.kf.setImage(with: url)
  
        return cell
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 2
        
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 1.5
        let objectHeight = mainView.movieListView.frame.size.height - mainView.secondSection.frame.size.height
        print(objectWidth)
        print(objectHeight)
    
        //print(mainView.movieListView.frame.size.height)
        
        
        return CGSize(width: objectWidth, height: objectHeight)
    }
}
