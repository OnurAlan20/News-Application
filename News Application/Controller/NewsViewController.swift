//
//  ViewController.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import UIKit

class NewsViewController: UIViewController,UITableViewDataSource {
    
    var searchTextField: SearchTextField!
    var articles: [Article] = []
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField = SearchTextField(searchIconTapAction: {
            self.searchIconTabbed()
        })
        searchTextField.delegate = searchTextField.self
        tableView.delegate = self
        tableView.dataSource = self
        
        setupScreen()
        
    }
    
    
    
}

extension NewsViewController:UITableViewDelegate{
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count // Her haber için ayrı bir bölüm oluştur
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Her bölümde sadece bir satır
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // Her bölüm arasında 10 birimlik boşluk bırak
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsTableViewCell(style: .default, reuseIdentifier: "NewsCell")
        cell.selectionStyle = .none 
        let article = articles[indexPath.section]
        
        
        cell.titleLabel.text = article.title
        cell.contentLabel.text = article.description
        
        if let endIndex = article.publishedAt.firstIndex(of: "T") {
            let dateSubstring = article.publishedAt[..<endIndex]
            cell.dateLabel.text = String(dateSubstring)
        } else {
            cell.dateLabel.text = article.publishedAt
        }
        cell.authorLabel.text = article.author
        
        NewsBrain.sharedInstance.stringUrlToImage(stringUrl: article.urlToImage) { image in
            if let image = image {
                cell.articleImageView.image = image
            } else {
                cell.articleImageView.image = .none
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailedVC = DetailedNewsViewController()
        detailedVC.article = articles[indexPath.section]
        navigationController?.pushViewController(detailedVC, animated: true)
        
    }
    
}

// setups search textfield and search button
extension NewsViewController{
    func setupScreen(){
        view.backgroundColor = UIColor.white
        setupNavBar()
        setupSearchTextField()
        setupTableView()
    }
    func setupNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Appcent NewsApp"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray, // Başlık metin rengi
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) // Başlık metin fontu
        ]
    }

    
    func setupSearchTextField() {
        let searchContainer = UIView()
        searchContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchContainer)
        
        NSLayoutConstraint.activate([
            searchContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchContainer.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        searchContainer.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchContainer.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor),
            searchTextField.widthAnchor.constraint(equalTo: searchContainer.widthAnchor, multiplier: 0.8)
        ])
        
        let searchButton = SearchButton()
        searchContainer.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchContainer.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor),
            searchButton.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor)
        ])
        
        searchButton.tapAction = {
            if let searchText = self.searchTextField.text{
                NewsAPI.sharedInstance.getNews(text: searchText) { [self] responseModel, error in
                    guard let responseModel = responseModel else {
                        print("Error fetching news: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    NewsAPI.sharedInstance.articles = responseModel.articles // Haberleri aldık
                    
                    searchIconTabbed()
                }
            }
        }
    }
    func searchIconTabbed(){
        
        DispatchQueue.main.async {
            self.articles = NewsAPI.sharedInstance.articles
            self.tableView.reloadData()
        }
    }
}




