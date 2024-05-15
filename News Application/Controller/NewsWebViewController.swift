//
//  NewsWebViewController.swift
//  News Application
//
//  Created by Onur Alan on 15.05.2024.
//

import UIKit
import WebKit


class NewsWebViewController: UIViewController {
    
    var article: Article?
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }
    
    
    
    
}
extension NewsWebViewController{
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func setupScreen(){
        view.backgroundColor = UIColor(rgb:0xEEEDEB)
        setupNavBar()
        setupWebView()
    }
    
    func setupNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.title = "News Source"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray, // Başlık metin rengi
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) // Başlık metin fontu
        ]
    }
    func setupWebView() {
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        if let urlString = article?.url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
