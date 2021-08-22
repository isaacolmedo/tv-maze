//
//  TVShowsViewModelTests.swift
//  TVMazeTests
//
//  Created by Isaac Olmedo on 22/08/21.
//

import XCTest
import RxSwift
@testable import TVMaze

class TVShowsViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    
    func test_fetch_items() {
        let sut = makeSUT()
        let expetation = expectation(description: "")
        
        sut.items.subscribe { shows in
            expetation.fulfill()
            XCTAssert(shows.count != 0)
        } onError: { error in
            expetation.fulfill()
            XCTFail(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        sut.fetchShows()
    
        wait(for: [expetation], timeout: 10)
    }
    
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line, dataSource: TVShowsViewModelDataSource = TVShowsViewModelTests.makeDataSource(), router: TVShowsRouter = TVShowsViewModelTests.makeRouter()) -> TVShowsViewModel {
        let sut = TVShowsViewModel(dataSource: dataSource, router: router)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    static private func makeDataSource() -> TVShowsViewModelDataSource {
        let context = Context()
        let dataSource = TVShowsViewModelDataSource(context: context)
        return dataSource
    }
    
    static private func makeRouter() -> TVShowsRouter{
        return TVShowsRouter(viewController: UIViewController())
    }
    
}
