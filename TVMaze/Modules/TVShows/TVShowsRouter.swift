//
//  TVShowsRouter.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import Foundation
import UIKit
import tvmaze_network
import RxSwift

final class TVShowsRouter: NSObject, RouterProtocol {
    internal weak var viewController: UIViewController?

    var detail: PublishSubject<Show> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    
    required init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        binds()
    }
    
    func binds() {
        detail.subscribe { show in
            self.pushToDetail(with: show)
        }.disposed(by: disposeBag)
    }
    
    private func pushToDetail(with show: Show) {
        let controller = TVShowDetailBuilder.build(with: TVShowDetailViewModelDataSource(context: Context(), show: show))
        controller.transitioningDelegate = self
        viewController?.navigationController?.present(controller, animated: true, completion: nil)
    }
}
