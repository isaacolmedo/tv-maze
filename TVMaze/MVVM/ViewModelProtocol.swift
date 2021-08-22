//
//  ViewModelProtocol.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    associatedtype DataSource: ViewModelDataSourceProtocol
    associatedtype Router: RouterProtocol

    init(dataSource: DataSource, router: Router)
}
