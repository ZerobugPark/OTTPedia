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
            } failHandler: {
                print("123")
            }
        }
        
    }
    
    private func configurationNavigationController() {
        
        let title = "영화검색"
        navigationItem.title = title
        navigationItem.backButtonTitle = ""
        
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
            } failHandler: {
                print("123")
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
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.width / 3.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        vc.movieInfo = (info: searchResult[indexPath.item], likeStatus: true)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}

// MARK: - TableView Prefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    
        if currentPage > totalPage {
            print("맥스입낟.")
            return
        } else {
           
            for path in indexPaths {
                if searchResult.count - 2 == path.row {
                    currentPage += 1
                    NetworkManger.shared.callRequest(api: .searchMoive(query: searchText, page: currentPage), type: Trending.self) { value in
                        self.searchResult.append(contentsOf: value.results)
                        self.searchView.tableView.reloadData()
                    } failHandler: {
                        print("123")
                    
                    }
                }
            }
        }
    }
    
    
    
    
    
}

