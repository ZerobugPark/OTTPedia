//
//  SearchViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/27/25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private var searchView = SearchView()
    var searchModel = SearchViewModel()
    

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
        
        bindData()
        searchModel.input.viewDidLoad.value = ()
    }
    
    
    private func bindData() {
        
        searchModel.output.viewDidLoad.lazyBind { [weak self] text in
            
            self?.navigationItem.title = self?.searchModel.output.navigationTitle
            self?.navigationItem.backButtonTitle = self?.searchModel.output.backButtonTitle
            
            if let search = text {
                self?.searchView.searchBar.text = search
            }
        }
        
        searchModel.output.searchResult.lazyBind { [weak self] _ in
            self?.searchView.tableView.reloadData()
            self?.view.endEditing(true)
        }
        
        searchModel.output.noResult.lazyBind { [weak self] status in
            self?.searchView.infoLabel.isHidden = status
        }
        
        searchModel.output.errorMessage.lazyBind { [weak self] msg in
            self?.showAPIAlet(msg: msg)
        }
        
        searchModel.output.updatedLike.lazyBind { [weak self] _ in
            self?.searchView.tableView.reloadData()
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
}


// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchModel.input.serachButtonTapped.value = searchBar.text
    }
}

// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel.output.searchResult.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        searchModel.input.checklikeStatus.value = indexPath.item
        cell.searchInfo(info: searchModel.output.searchResult.value[indexPath.row], likeStatus: searchModel.output.likeImageStatus)
        cell.selectionStyle = .none
        
        cell.likeButton.tag = indexPath.row
        cell.delegate = self
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.width / 3.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        searchModel.input.checklikeStatus.value = indexPath.item
        
        vc.detailModel.movieInfo = (info: searchModel.output.searchResult.value[indexPath.row], likeStatus: searchModel.output.likeImageStatus)
        vc.detailModel.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
}




// MARK: - TableView Prefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        searchModel.input.pagenationStart.value = indexPaths
    }
    
}


// MARK: - PassMovieLikeDelegate Delegate
extension SearchViewController: PassMovieLikeDelegate {
    
    func likeButtonTapped(index: Int, status: Bool) {
        searchModel.input.likeButtonTapped.value = (index, status)
    }
    
    func detailViewLikeButtonTapped(id: Int, status: Bool) {
        searchModel.input.likeUpdate.value = (id, status)
    }
    
}
