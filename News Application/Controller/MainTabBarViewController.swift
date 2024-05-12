//
//  MainTabBarViewController.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = UIColor(rgb:0x252422)

        let firstViewController = NewsViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        let secondViewController = FavoritesViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))

        viewControllers = [firstViewController, secondViewController]
    }
}
