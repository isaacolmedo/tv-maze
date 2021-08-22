//
//  ViewControllerProtocol.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import UIKit

protocol ViewControllerProtocol: UIViewController {
    associatedtype ViewModel: ViewModelProtocol
    func configure(with viewModel: ViewModel)
    static func instantiate() -> Self
}

extension ViewControllerProtocol {
    static func instantiate() -> Self {
        UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as! Self
    }
}
