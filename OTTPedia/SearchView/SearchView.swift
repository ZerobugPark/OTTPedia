//
//  SearchView.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/27/25.
//

import UIKit

import SnapKit

final class SearchView: BaseView {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    let infoLabel = CustomLabel(boldStyle: true, fontSize: 14, color: ColorList.white.color)

  
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(infoLabel)
        
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(self).inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(self).inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.center.equalTo(self)
        }

    }
    
    override func configureView() {
        
        
        let placeholder = "어떤 영화가 궁금하신가요?"
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: [NSAttributedString.Key.foregroundColor : ColorList.lightGray.color])
        searchBar.searchTextField.backgroundColor =  ColorList.darkGray.color
        searchBar.searchTextField.leftView?.tintColor = ColorList.white.color // 돋보기 색상 변경
        searchBar.searchTextField.textColor = .white
        searchBar.searchBarStyle = .minimal
        
        
        
        tableView.bounces = false
        tableView.backgroundColor = ColorList.black.color
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = ColorList.lightGray.color
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let msg = "원하는 검색결과를 찾지 못했습니다."
        infoLabel.text = msg
        infoLabel.isHidden = true

        
   
    }

}
