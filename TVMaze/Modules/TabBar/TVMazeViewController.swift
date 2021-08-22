//
//  TVMazeViewController.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 21/08/21.
//

import UIKit

typealias TVMazeTabs = (
    shows: UIViewController,
    favorites: UIViewController
)

class TVMazeTabBarViewController: UITabBarController {
    
    init(tabs: TVMazeTabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.shows, tabs.favorites]
        tabBar.tintColor = .primary
        tabBar.isTranslucent = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
