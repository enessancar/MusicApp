//
//  PlaylistView.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit
import SnapKit

final class PlaylistView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
    }
}
