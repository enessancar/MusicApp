//
//  File.swift
//  MusicApp
//
//  Created by Enes Sancar on 9.12.2023.
//

import UIKit
import SnapKit

protocol RecentSearchesViewDelegate {
    func recentSearchButtonTapped()
}

final class RecentSearchesView: UIView {
    
    var delegate: RecentSearchesViewDelegate?
    
    //MARK: - Properties
    private lazy var recentSearchesLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Searches"
        label.font = .boldSystemFont(ofSize: FontSize.headline)
        return label
    }()
    
    private lazy var clearRecentSearchesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear all", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(clearRecentSearchButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [
            recentSearchesLabel, spacer, clearRecentSearchesButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var recentSearchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHeaderStackView()
        configureRecentSearchesTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeaderStackView() {
        addSubview(headerStackView)
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    private func configureRecentSearchesTableView() {
        addSubview(recentSearchesTableView)
        
        recentSearchesTableView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension RecentSearchesView {
    @objc private func clearRecentSearchButton() {
        delegate?.recentSearchButtonTapped()
    }
}

