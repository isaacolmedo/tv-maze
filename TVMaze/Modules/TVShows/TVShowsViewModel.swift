//
//  TVShowsViewModel.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import tvmaze_network
import RxSwift
import Foundation

struct TVShowsViewModelDataSource: ViewModelDataSourceProtocol {
    var context: Context
}

final class TVShowsViewModel: ViewModelProtocol, TableViewShowsDecorator, Likeable {
    private let dataSource: TVShowsViewModelDataSource
    private let router: TVShowsRouter
    private let api = ShowsAPI()
    private let disposeBag = DisposeBag()
    private var staticItems = [Show]()
    
    let items: PublishSubject<[Show]> = PublishSubject()
    let like: PublishSubject<(Bool, Int)> = PublishSubject()
    var title: String = "TVShows"
    var itemSelected: PublishSubject<Show> = PublishSubject()
 
    init(dataSource: TVShowsViewModelDataSource, router: TVShowsRouter) {
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
        itemSelected.subscribe(router.detail).disposed(by: disposeBag)
    }
    
    func fetchShows() {
        api.fetchShows().asObservable().subscribe(onNext: {  [weak self] shows in
            self?.items.onNext(shows)
        }, onError: { error in
            debugPrint("Show error")
        }).disposed(by: disposeBag)
    }
    
    func viewWillAppear() {
        fetchShows()
    }
}

//MARK:- LIKEABLE
extension TVShowsViewModel {
    func remove(at index: Int) {
        staticItems.remove(at: index)
        items.onNext(staticItems)
    }
}

//MARK:- TVShowItemTableViewCellDataSource
extension Show: TVShowItemTableViewCellDataSource {
    var title: String { name }
    var url: URL { guard let url = URL(string: image.medium) else { fatalError("Image for TVShow Cant be nil") }; return url }
    var isFavorite: Bool { UserDefaults.standard.bool(forKey: "\(id)") }
}
