//
//  SynopsisTableViewCell.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

import SnapKit

final class SynopsisTableViewCell: BaseTableViewCell {

    static let id = "SynopsisTableViewCell"
    
    private let sectionLabel = CustomLabel(boldStyle: true, fontSize: 16, color: ColorList.white)
    private let overviewLabel = CustomLabel(boldStyle: false, fontSize: 14, color: ColorList.white)
    private let hideButton = UIButton()
    
    private var buttonTtile = "More"
    private var hideButtonStatus = false
    
    var delegate: PassHiddenButtonDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        hideButton.addTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
    }
    
    
    override func configureHierarchy() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(hideButton)
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        hideButton.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(16)
            // heigth로 잡을 경우 오토디멘션이 동작 X
            // heigth로 기준을 잡을 경우, bottom까지 다른게 더 있다고 생각해서 높이를 계산하지 못하는 것으로 보임
            make.bottom.equalTo(contentView).inset(16)
        }
        
    }
    
    override func configureView() {
        
        hideButton.setTitle(buttonTtile, for: .normal)
        hideButton.setTitleColor(ColorList.main, for: .normal)
        hideButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        overviewLabel.numberOfLines = 3 // 높이가 NumberofLines에 맞춰 자동으로 반영
        overviewLabel.lineBreakMode = .byTruncatingTail
    }
    
    
    func setupLabel(title: String, overView: String) {
        
        sectionLabel.text = title
        overviewLabel.text = overView
        hideButton.setTitle(buttonTtile, for: .normal)
    }
    
    @objc private func hideButtonTapped(_ sender: UIButton) {
        
        hideButtonStatus.toggle()
                
        if hideButtonStatus {
            overviewLabel.numberOfLines = 0
        } else {
            overviewLabel.numberOfLines = 3
        }
        
        buttonTtile = hideButtonStatus ? "Hide" : "More"
        hideButton.setTitle(buttonTtile, for: .normal)
        delegate?.hidebuttonTapped()
        
    }
}
