//
//  TVFavoriteShowsBuilder.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 21/08/21.
//

import Foundation

enum TVFavoriteShowsBuilder: BuilderProtocol {
    typealias ViewController = TVShowsViewController
}

extension TVFavoriteShowsBuilder {
    static func build(with dataSource: TVFavoriteShowsViewModelDataSource) -> TVShowsViewController {
        let viewController = TVShowsViewController.instantiate()
        let router = TVFavoriteShowsRouter(viewController: viewController)
        let viewModel = TVFavoriteShowsViewModel(dataSource: TVFavoriteShowsViewModelDataSource(context: Context()), router: router)
        viewController.set(decorator: viewModel)
        return viewController
    }
}
