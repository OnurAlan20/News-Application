//
//  FavoritesViewController.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDataSource {

    let tableView = UITableView()
    var articles: [Article] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        view.backgroundColor = UIColor.white
        
        if let fetchedArticles = NewsBrain.sharedInstance.getAllArticles(){
            articles = fetchedArticles
            tableView.reloadData()
        }
        
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        tableView.backgroundColor = UIColor.white// Koyu arka plan rengi
        tableView.separatorStyle = .none
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
    }
    

}
extension FavoritesViewController:UITableViewDelegate{
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
        
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cell.articleImageView.image = image
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailedVC = DetailedNewsViewController()
        detailedVC.article = articles[indexPath.section]
        navigationController?.pushViewController(detailedVC, animated: true)
        
        
        
    }
    
}
