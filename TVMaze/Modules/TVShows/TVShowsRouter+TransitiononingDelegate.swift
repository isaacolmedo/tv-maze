//
//  TVShowsViewController+TransitiononingDelegate.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import UIKit

extension TVShowsViewController: UIViewControllerTransitioningDelegate {

    // B1 - 2
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

    // B1 - 3
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

