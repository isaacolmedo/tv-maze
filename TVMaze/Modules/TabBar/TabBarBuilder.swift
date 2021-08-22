//
//  TabBarBuilder.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 21/08/21.
//

import UIKit

class TabBarBuilder {
    
    static func build(with submodules: TabBarRouter.Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(using: submodules)
        let tabBarController = TVMazeTabBarViewController(tabs: tabs)
        return tabBarController
    }
    
}
