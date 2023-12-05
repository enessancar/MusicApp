//
//  MusicCollectionViewCell.swift
//  MusicApp
//
//  Created by Enes Sancar on 5.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class MusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "MusicCollectionViewCell"
    
    //MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let layer = UIView()
        layer.backgroundColor = .systemBackground
        layer.layer.opacity = 0.5
        imageView.addSubview(layer)
        layer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSize.subHeadline)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 8
    }
    
    private func configureImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureLabel() {
        imageView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func updateUI(playlist: Playlist) {
        imageView.kf.setImage(with: playlist._pictureXL.asUrl)
        label.text = playlist._title
    }
    
    func updateUI(genresPlaylist: GenresPlayList) {
        imageView.kf.setImage(with: genresPlaylist._pictureXL.asUrl)
        label.text = genresPlaylist._name
    }
    
    func updateUI(artist: Artist) {
        imageView.kf.setImage(with: artist._pictureXL.asUrl)
        label.text = artist._name
    }
}
