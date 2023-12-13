//
//  SearchResultView.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit
import SnapKit

final class SearchResultView: UIView {
    
    lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        addSubview(searchResultTableView)
        
        searchResultTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
        }
    }
}
