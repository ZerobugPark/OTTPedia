//
//  MainViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/25/25.
//

import UIKit

final class MainViewController: UIViewController {

    private var mainView = MainView()
    private var trendingResult: [Results] = []
    
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
        mainView.removeAllButton.addTarget(self, action: #selector(removeAllButtonTapped), for: .touchUpInside)
        
        
        NetworkManger.shared.callRequest(api: .trending(), type: Trending.self) { value in
            self.trendingResult = value.results
            self.mainView.collectionView.reloadData()
        } failHandler: {
            print("123")
        }

        
    }
    

    private func configurationNavigationController() {
        
        let title = "OTTPedia"
        navigationItem.title = title
        navigationItem.backButtonTitle = ""
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        print(#function)
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        
        print(#function)
    }
    
    @objc private func removeAllButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func searchButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
        

}



// MARK: - CollectionView Delegate

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return trendingResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.id, for: indexPath) as! MovieListCollectionViewCell
        cell.updateTrending(trend: trendingResult[indexPath.item])
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}

// MARK: - CollectionViewDelegateFlowLayout Delegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 2
                
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 1.5
        let objectHeight = mainView.movieListView.frame.size.height - mainView.secondSection.frame.size.height
//        print(objectWidth)
//        print(objectHeight)

        
        return CGSize(width: objectWidth, height: objectHeight)
    }
}
