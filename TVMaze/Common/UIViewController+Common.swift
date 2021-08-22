//
//  UIViewController+Common.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertViewController.addAction(action)
        }
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showAlert(with error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}
