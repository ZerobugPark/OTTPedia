//
//  SearchView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/27/25.
//

import UIKit

class SearchView: BaseView {

    let searchController = UISearchController()
    let tableView = UITableView()

  
    override func configureHierarchy() {
        addSubview(tableView)

        
    }
    
    override func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(60)
            make.horizontalEdges.equalTo(self).inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }

    }
    
    override func configureView() {
        tableView.bounces = false
        
        //네비게이션 컨트롤러 영역 미침범
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.backgroundColor = ColorList.darkGray.color
        
        // Cancel 버튼 삭제
        searchController.searchBar.setShowsCancelButton(false, animated: false)
   
    }

}
