//
//  SearchViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/27/25.
//

import UIKit

class SearchViewController: UIViewController {

    
    private var searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        

        configurationNavigationController()

       // self.searchView.searchController.searchBar.delegate = self
    }
    
    private func configurationNavigationController() {
        
        let title = "영화검색"
        navigationItem.title = title


    }




}


// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
   // func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//        changeButtonColor(status: false)
//        results.removeAll()
//        filter =  "relevant"
//        searchView.collectionView.reloadData()
//        
//        guard let text = searchBar.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty  else {
//            let msg = "1글자 이상의 검색어를 입력해주세요."
//            showAlert(msg: msg)
//            // 서치바 원상태로 복귀
//            searchView.searchController.isActive = false
//            return
//        }
//        
//        searchText = text
//        page = 1
//        
//        NetworkManager.shared.callRequest(api: .searchImage(query: searchText, filter: filter, page: String(page)), type: UnslpashGetImage.self) { value in
//           
//            self.getInfo = value
//             
//            if self.getInfo.total == 0, self.getInfo.results.isEmpty {
//                self.searchView.label.text = "검색결과가 없습니다."
//                self.searchView.label.isHidden = false
//            } else {
//                self.searchView.label.isHidden = true
//            }
//            self.results = self.getInfo.results
//            self.backupResults = self.results
//            
//            if self.getInfo.total > 0, !self.getInfo.results.isEmpty {
//                self.searchView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            }
//        } failHandler: { status in
//            let msg = Error.errorMsg(satus: status)
//            self.showAlert(msg: msg)
//        }
//        
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        results.removeAll()
//        searchView.collectionView.reloadData()
//        self.searchView.label.text = "사진을 검색해보세요."
//        self.searchView.label.isHidden = false
//    }
//    
//    
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        searchView.searchController.searchBar.text = ""
//        return true
//    }

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.width / 3.0)
    }
    
    
}
