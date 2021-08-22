//
//  TabBarRouter.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 21/08/21.
//

import UIKit

class TabBarRouter {
    
    var viewController: UIViewController
    var submodules: Submodules
    
    typealias Submodules = (
        shows: UIViewController,
        favorites: UIViewController
    )
    
    init(viewController: UIViewController, submodules: Submodules) {
        self.viewController = viewController
        self.submodules = submodules
    }
}


extension TabBarRouter {
    
    static func tabs(using submodules: Submodules) -> TVMazeTabs {
        let showsTabBarItem = UITabBarItem(title: "Shows", image: UIImage(named: "shows"), tag: 0)
        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "like"), tag: 1)
        
        submodules.shows.tabBarItem = showsTabBarItem
        submodules.favorites.tabBarItem = favoritesTabBarItem
        
        return (
            shows: submodules.shows,
            favorites: submodules.favorites
        )
    }
    
}
