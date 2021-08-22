//
//  TVFavoriteShowsRouter.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 21/08/21.
//

import Foundation
import UIKit
import RxSwift
import tvmaze_network

final class TVFavoriteShowsRouter: RouterProtocol {
    internal weak var viewController: UIViewController?
    
    var detail: PublishSubject<Show> = PublishSubject()
    
    private let disposeBag = DisposeBag()

    required init(viewController: UIViewController) {
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
        viewController?.navigationController?.present(controller, animated: true, completion: nil)
    }
}
