//
//  TVShowTests.swift
//  TVShowTests
//
//  Created by Isaac Olmedo on 20/08/21.
//

import XCTest
import tvmaze_network
import RxSwift
@testable import TVMaze

class TVShowTests: XCTestCase {
    
    func test_verify_title() {
        let sut = makeSUT()
        
        XCTAssert(sut.title == "TVShows")
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> TVShowsViewController {
        let sut = TVShowsBuilder.build(with: TVShowsViewModelDataSource(context: Context()))
        sut.loadViewIfNeeded()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.",
                         file: file,
                         line: line)
        }
    }
    
    func trackMemoryLeaks(for instances: AnyObject...,  file: StaticString = #file, line: UInt = #line) {
        for instance in instances {
            trackForMemoryLeaks(instance, file: file, line: line)
        }
    }
}

class MockTableViewShowsDecorator: TableViewShowsDecorator {
    
    var calls: [Bool] = []
    
    var items: PublishSubject<[Show]> = PublishSubject()
    
    var title: String
    
    var itemSelected: PublishSubject<Show> = PublishSubject()
    
    init(title: String) {
        self.title = title
    }
    
    func remove(at index: Int) {
        calls.append(true)
    }
    
    func viewWillAppear() {
        calls.append(true)
    }
}
