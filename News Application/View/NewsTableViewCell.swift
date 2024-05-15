//
//  NewsTableViewCell.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    
   
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true // Resim içeriğini sınırlayarak yuvarlatılmış köşelerde göstermek için
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgb: 0x2c2c2b)
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(rgb: 0x2c2c2b)
        label.textAlignment = .right // Sağa hizalı
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(rgb: 0x2c2c2b)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor(rgb:0xEEEDEB)
        layer.cornerRadius = 10
        
        addSubview(articleImageView)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(dateLabel)
        addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            
            
            // Yeni constraint'ler
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            articleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            articleImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8),
            articleImageView.widthAnchor.constraint(equalToConstant: 100),
            articleImageView.heightAnchor.constraint(equalToConstant: 200), // Resim boyutu için
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8), // Başlığın altından başlat
            contentLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor), // İçerikle aynı başlangıçta
            dateLabel.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor), // İçerikle aynı bitişte
            
            authorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8), // Tarihin altından başlat
            authorLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor), // Tarih ile aynı başlangıçta
            authorLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor), // Tarih ile aynı bitişte
            authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8) // En alta hizala
        ])
        
        
    }
    
    
    
    
    
}
