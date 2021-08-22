//
//  TVShowDetailRouter.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import Foundation
import UIKit

final class TVShowDetailRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func openimdb(with imdb: String) {
        if let url = URL(string: imdb) {
            UIApplication.shared.open(url)
        }
    }
}
