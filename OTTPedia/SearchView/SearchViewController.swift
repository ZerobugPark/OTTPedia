//
//  SearchViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/27/25.
//

import UIKit

final class SearchViewController: UIViewController {
    

    
    private var searchResult: [Results] = []
    private var currentPage = 1
    private var searchView = SearchView()
    private var totalPage = 0
    private var likeMovie: [String: Bool] = [:]
    
    var searchText = ""
    var textInfo: ((String) -> Void)?
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.prefetchDataSource = self
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        
        searchView.searchBar.delegate = self
        
        configurationNavigationController()
        
        
        if !searchText.isEmpty {
            NetworkManger.shared.callRequest(api: .searchMoive(query: searchText, page: currentPage), type: Trending.self) { value in
                self.searchResult = value.results
                self.totalPage = value.totalPage
                self.searchView.tableView.reloadData()
                self.noData()
                self.searchView.searchBar.text = self.searchText
            } failHandler: { stauts in
                let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                self.showAPIAlet(msg: msg)
            }
        }
        likeMovie = ProfileUserDefaults.likeMoive
    }
    
    private func configurationNavigationController() {
        
        let title = "영화 검색"
        navigationItem.title = title
        navigationItem.backButtonTitle = ""
        
    }
    
    private func checkLikeStatus(index: Int) -> Bool {
        let likeStatus = likeMovie[String(searchResult[index].id)] ?? false
        
        return likeStatus
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        likeMovie = ProfileUserDefaults.likeMoive

    }
    
    
}


// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            searchText = text
            currentPage = 1
            NetworkManger.shared.callRequest(api: .searchMoive(query: searchText, page: currentPage), type: Trending.self) { value in
                self.searchResult = value.results
                self.totalPage = value.totalPage
                self.searchView.tableView.reloadData()
                self.noData()
            } failHandler: { stauts in
                let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                self.showAPIAlet(msg: msg)
            }
            textInfo?(searchText)
        }
        
        view.endEditing(true)
    }
    
    private func noData() {
        if searchResult.isEmpty {
            searchView.infoLabel.isHidden = false
        } else {
            searchView.infoLabel.isHidden = true
        }
    }
}

// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.searchInfo(info: searchResult[indexPath.row])
        cell.selectionStyle = .none
        
        cell.likeButton.tag = indexPath.row
        cell.delegate = self
        
        let image = checkLikeStatus(index: indexPath.row) ? "heart.fill" : "heart"
        cell.likeButton.setImage(UIImage(systemName: image), for: .normal)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.width / 3.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.movieInfo = (info: searchResult[indexPath.row], likeStatus: checkLikeStatus(index: indexPath.row))
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
}




// MARK: - TableView Prefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        if currentPage > totalPage {
            print("맥스입니다")
            return
        } else {
            
            for path in indexPaths {
                if searchResult.count - 2 == path.row {
                    currentPage += 1
                    NetworkManger.shared.callRequest(api: .searchMoive(query: searchText, page: currentPage), type: Trending.self) { value in
                        self.searchResult.append(contentsOf: value.results)
                        self.searchView.tableView.reloadData()
                    } failHandler: { stauts in
                        let msg = ApiError.shared.apiErrorDoCatch(apiStatus: stauts)
                        self.showAPIAlet(msg: msg)
                    }
                }
            }
        }
    }
    
}


// MARK: - PassMovieLikeDelegate Delegate
extension SearchViewController: PassMovieLikeDelegate {
    
    func likeButtonTapped(index: Int, status: Bool) {
        likeMovie.updateValue(status, forKey: String(searchResult[index].id))
        ProfileUserDefaults.likeMoive = likeMovie
        
    }
    
    func detailViewLikeButtonTapped(id: Int, status: Bool) {
        likeMovie.updateValue(status, forKey: String(id))
        ProfileUserDefaults.likeMoive = likeMovie
        searchView.tableView.reloadData()
        
    }
    
}
