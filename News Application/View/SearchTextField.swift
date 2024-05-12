//
//  SearchTextField.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import UIKit

class SearchTextField: UITextField {
    let newsAPI = NewsAPI()
    
    let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        setupSearchIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
        setupSearchIcon()
    }
    
    private func setupTextField() {
        placeholder = "Search"
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSearchIcon() {
        addSubview(searchIconImageView)
        NSLayoutConstraint.activate([
            searchIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 20),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchIconTapped))
        searchIconImageView.isUserInteractionEnabled = true
        searchIconImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func searchIconTapped() {
        newsAPI.getNews(text: "tesla")
    }
}
