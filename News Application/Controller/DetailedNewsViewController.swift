//
//  DetailedNewsViewController.swift
//  News Application
//
//  Created by Onur Alan on 12.05.2024.
//

import UIKit

class DetailedNewsViewController: UIViewController {
    
    var article: Article?
    var isFavorite: Bool = false
    
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    let articleImageView = UIImageView()
    let dateLabel = UILabel()
    let authorLabel = UILabel()
    let contentLabel = UILabel()
    let buttonContainerView = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let articleIsFaved = NewsSwiftCore.sharedInstance.getArticleWithTitle(article?.title ?? "")
        if articleIsFaved != nil {
            isFavorite = true
        }
        setupScreen()
        
    }
    
}

extension DetailedNewsViewController{
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favoriteButtonTapped() {
        if isFavorite {
            // Makale zaten favorilerde, kaldır
            if let title = article?.title, NewsSwiftCore.sharedInstance.deleteArticleWithTitle(title) {
                isFavorite = false
                setupNavBar()
            }
        } else {
            // Makale favorilere ekleniyorz
            if let article = article {
                NewsSwiftCore.sharedInstance.addArticle(article: article)
                isFavorite = true
                setupNavBar()
            }
        }
    }
    
    
    @objc func shareButtonTapped() {
        
        guard let articleUrl = article?.url else {
            print("Haber linki bulunamadı.")
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [articleUrl], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    @objc func bottomButtonTapped() {
        let newsWebWiew = NewsWebViewController()
        newsWebWiew.article = self.article
        navigationController?.pushViewController(newsWebWiew, animated: true)
    }
}

extension DetailedNewsViewController{
    
    func setupScreen(){
        setupNavBar()
        setupScrollView()
        setupArticleContent()
        addBottomButton()
    }
    
    func setupNavBar() {
        view.backgroundColor = UIColor(rgb:0xEEEDEB)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        let favImage = UIImage(systemName: "heart")
        let filledFavImage = UIImage(systemName: "heart.fill")
        
        
        let favButton = UIBarButtonItem(image: isFavorite ? filledFavImage : favImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        
        navigationItem.rightBarButtonItems = [shareButton,favButton]
    }
    
    
}

extension DetailedNewsViewController {
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        
        buttonContainerView.translatesAutoresizingMaskIntoConstraints = false
        buttonContainerView.backgroundColor = UIColor(rgb: 0x007aff)
        buttonContainerView.layer.cornerRadius = 10 // Yuvarlatılmış köşeler
        view.addSubview(buttonContainerView)
        
        NSLayoutConstraint.activate([
            buttonContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonContainerView.heightAnchor.constraint(equalToConstant: 50) // Örnek bir yükseklik
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: buttonContainerView.topAnchor,constant: -20)
        ])
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setupArticleContent() {
        
        let articleImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true 
            return imageView
        }()
        NewsBrain.sharedInstance.stringUrlToImage(stringUrl: article?.urlToImage) { image in
            if let image = image {
                articleImageView.image = image
            } else {
                articleImageView.image = .none
            }
            
        }
        
        scrollView.addSubview(articleImageView)
        
        
        // Date Label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.textColor = UIColor(rgb: 0x2c2c2b)

        dateLabel.sizeToFit()
        scrollView.addSubview(dateLabel)
        
        if let endIndex = article?.publishedAt.firstIndex(of: "T") {
            let dateSubstring = article?.publishedAt[..<endIndex]
            dateLabel.text = String(dateSubstring!)
        } else {
            dateLabel.text = article?.publishedAt
        }
        
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(authorLabel)
        authorLabel.font = UIFont.boldSystemFont(ofSize: 16)
        authorLabel.textAlignment = .left
        authorLabel.sizeToFit()
        authorLabel.textColor = UIColor(rgb: 0x2c2c2b)
        authorLabel.text = article?.author
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.numberOfLines = 0 
        contentLabel.textColor = UIColor(rgb: 0x2c2c2b)
        contentLabel.sizeToFit()
        
        
        scrollView.addSubview(contentLabel)
        if let endIndex = article?.content.firstIndex(of: "[") {
            let contentSubStr = article?.content[..<endIndex]
            contentLabel.text = String(contentSubStr!)
        } else {
            contentLabel.text = article?.content
        }
        
        
        
        // Constraints
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            articleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            articleImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),    articleImageView.widthAnchor.constraint(equalToConstant: view.frame.width - 16),
            articleImageView.heightAnchor.constraint(equalToConstant: 210),
            
            dateLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 0),
            authorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: -20),
            
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}

extension DetailedNewsViewController {
    func addBottomButton() {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(rgb: 0x007aff)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("News Source", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        buttonContainerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: buttonContainerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor)
        ])
    }
    
    
    
    
}

