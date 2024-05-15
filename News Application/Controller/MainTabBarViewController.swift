//
//  MainTabBarViewController.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let navController = UINavigationController(rootViewController: NewsViewController())
    let secondViewController = UINavigationController(rootViewController: FavoritesViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb:0x252422)
        
        
        navController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        secondViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        viewControllers = [navController, secondViewController]
    }
}
