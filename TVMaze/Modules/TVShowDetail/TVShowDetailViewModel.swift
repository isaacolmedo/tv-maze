//
//  TVShowDetailViewModel.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import Foundation
import RxSwift
import tvmaze_network

struct TVShowDetailViewModelDataSource: ViewModelDataSourceProtocol {
    var context: Context
    var show: Show
}

final class TVShowDetailViewModel: ViewModelProtocol {
    private let dataSource: TVShowDetailViewModelDataSource
    private let router: TVShowDetailRouter
    private let disposeBag = DisposeBag()
    private let show: Show
    
    let imageURL: BehaviorSubject<URL> = BehaviorSubject(value: URL(string: "www.google.com")!)
    let title: BehaviorSubject<String> = BehaviorSubject(value: "")
    let resume: BehaviorSubject<NSAttributedString> = BehaviorSubject(value: NSAttributedString())
 
    init(dataSource: TVShowDetailViewModelDataSource, router: TVShowDetailRouter) {
        self.dataSource = dataSource
        self.router = router
        self.show = dataSource.show
        binds()
    }
    
    private func binds() {
        if let url = URL(string: show.image.original) {
            imageURL.onNext(url)
        }
        title.onNext(show.name)
        resume.onNext(show.summary.htmlToAttributedString)
    }

}

extension String {

    var htmlToAttributedString: NSMutableAttributedString {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data,
                                          options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  NSMutableAttributedString()
        }
     }
}
