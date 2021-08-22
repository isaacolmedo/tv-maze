//
//  AppDelegate.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let shows = TVShowsBuilder.build(with: TVShowsViewModelDataSource(context: Context()))
        let navigationControllerShows = UINavigationController.init(rootViewController: shows)
        
        let favorites = TVFavoriteShowsBuilder.build(with: TVFavoriteShowsViewModelDataSource(context: Context()))
        let navigationControllerFavorites = UINavigationController.init(rootViewController: favorites)
        
        let submodules = (
            shows: navigationControllerShows,
            favorites: navigationControllerFavorites
        )
        
        let tabBarController = TabBarBuilder.build(with: submodules)
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        return true
    }
}

