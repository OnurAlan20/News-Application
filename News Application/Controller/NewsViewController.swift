//
//  ViewController.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import UIKit

class NewsViewController: UIViewController {

    let searchTextField = SearchTextField()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb:0x252422)
        setupViews()
        
            
    }
    func setupViews() {
            
            
            view.addSubview(searchTextField)
            NSLayoutConstraint.activate([
                searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                searchTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        }


}

