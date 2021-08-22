//
//  TVFavoriteViewModelTests.swift
//  TVMazeTests
//
//  Created by Isaac Olmedo on 22/08/21.
//

import XCTest
import RxSwift
@testable import TVMaze

class TVFavoriteViewModelTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func test_item_with_id1_add_as_favorite() {
        let sut = makeSUT()
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.setValue(true, forKey: "1")
        let expetation = expectation(description: "")
        
        sut.items.subscribe { shows in
            expetation.fulfill()
            XCTAssert(shows.first(where: { $0.id == 1 }) != nil)
        } onError: { error in
            expetation.fulfill()
            XCTFail(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        sut.fetchShows()
    
        wait(for: [expetation], timeout: 10)
    }
    
    func test_item_with_id33_add_as_favorite() {
        let sut = makeSUT()
        UserDefaults.standard.removeObject(forKey: "33")
        UserDefaults.standard.setValue(true, forKey: "33")
        let expetation = expectation(description: "")
        
        sut.items.subscribe { shows in
            expetation.fulfill()
            XCTAssert(shows.first(where: { $0.id == 1 }) != nil)
        } onError: { error in
            expetation.fulfill()
            XCTFail(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        sut.fetchShows()
    
        wait(for: [expetation], timeout: 10)
    }
    
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line, dataSource: TVFavoriteShowsViewModelDataSource = TVFavoriteViewModelTests.makeDataSource(), router: TVFavoriteShowsRouter = TVFavoriteViewModelTests.makeRouter()) -> TVFavoriteShowsViewModel {
        let sut = TVFavoriteShowsViewModel(dataSource: dataSource, router: router)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    static private func makeDataSource() -> TVFavoriteShowsViewModelDataSource {
        let context = Context()
        let dataSource = TVFavoriteShowsViewModelDataSource(context: context)
        return dataSource
    }
    
    static private func makeRouter() -> TVFavoriteShowsRouter{
        return TVFavoriteShowsRouter(viewController: UIViewController())
    }
}
