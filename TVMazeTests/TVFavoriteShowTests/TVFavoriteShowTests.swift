//
//  TVFavoriteShowTests.swift
//  TVMazeTests
//
//  Created by Isaac Olmedo on 22/08/21.
//

import XCTest
import tvmaze_network
import RxSwift
@testable import TVMaze

class TVFavoriteShowTests: XCTestCase {

    func test_favorite_title() {
        let sut = makeSUT()
        
        XCTAssert(sut.title == "Favorite Shows")
    }


    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> TVShowsViewController {
        let sut = TVFavoriteShowsBuilder.build(with: TVFavoriteShowsViewModelDataSource(context: Context()))
        sut.loadViewIfNeeded()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
