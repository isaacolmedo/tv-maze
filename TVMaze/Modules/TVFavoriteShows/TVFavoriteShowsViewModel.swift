//
//  TVFavoriteShowsViewModel.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 21/08/21.
//

import tvmaze_network
import RxSwift
import Foundation

struct TVFavoriteShowsViewModelDataSource: ViewModelDataSourceProtocol {
    var context: Context
}

final class TVFavoriteShowsViewModel: TableViewShowsDecorator {
    private let dataSource: TVFavoriteShowsViewModelDataSource
    private let router: TVFavoriteShowsRouter
    private let disposeBag = DisposeBag()
    private var staticItems = [Show]()
    private let api = ShowsAPI()
    
    let items: PublishSubject<[Show]> = PublishSubject()
    let like: PublishSubject<(Bool, Int)> = PublishSubject()
    var title: String = "Favorite Shows"
    var itemSelected: PublishSubject<Show> = PublishSubject()
 
    init(dataSource: TVFavoriteShowsViewModelDataSource, router: TVFavoriteShowsRouter) {
        self.dataSource = dataSource
        self.router = router
        binds()
    }
    
    private func binds() {
        items.subscribe { [weak self] shows in
            self?.staticItems = shows
        }.disposed(by: disposeBag)
        
        like.subscribe { (isLike, id) in
            UserDefaults.standard.setValue(isLike, forKey: "\(id)")
        }.disposed(by: disposeBag)
    }
    
    func fetchShows() {
        api.fetchShows().asObservable().subscribe(onNext: { [weak self] shows in
            self?.items.onNext(shows.filter { UserDefaults.standard.bool(forKey: "\($0.id)") })
        }, onError: { error in
            debugPrint("Show error")
        }).disposed(by: disposeBag)
    }
    
    func viewWillAppear() {
        fetchShows()
    }
}

//MARK:- LIKEABLE
extension TVFavoriteShowsViewModel {
    func remove(at index: Int) {
        items.onNext(staticItems)
    }
}



