//
//  TVFavoriteShowsRouter.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 21/08/21.
//

import Foundation
import UIKit

final class TVFavoriteShowsRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushToDetail(with id: String) { }
}
