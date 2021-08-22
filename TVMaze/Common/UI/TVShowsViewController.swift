//
//  TVShowsViewController.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
import tvmaze_network

protocol Likeable {
    var like: PublishSubject<(Bool, Int)> { get }
}

protocol TableViewShowsDecorator {
    var items: PublishSubject<[Show]> { get }
    var title: String { get }
    var itemSelected: PublishSubject<Show> { get }
    func remove(at index: Int)
    func viewWillAppear()
}

final class TVShowsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: TableViewShowsDecorator!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        binds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func configureView() {
        configureTableView()
        configureNavigationBar()
        title = viewModel.title
        
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "TVShowItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TVShowItemTableViewCell")
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary]
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.primary]
        }
    }
    
    private func binds() {
        viewModel
            .items
            .bind(to: tableView.rx.items(cellIdentifier: "TVShowItemTableViewCell", cellType: TVShowItemTableViewCell.self)) {
                [weak self] (row, element, cell) in
                guard let self = self else { return }
                cell.configure(with: element)
                if let like = self.viewModel as? Likeable {
                    cell.didLikeAction.subscribe(like.like).disposed(by: self.disposeBag)
                } else {
                    cell.removeLikeButton()
                }
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemDeleted
            .subscribe(onNext: { [weak self] indexPath in self?.viewModel.remove(at: indexPath.row) })
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Show.self)
            .subscribe(viewModel.itemSelected)
            .disposed(by: disposeBag)
    }
}

extension TVShowsViewController: ViewControllerProtocol {
    func configure(with viewModel: TVShowsViewModel) {
        self.viewModel = viewModel
    }
    
    func set(decorator: TableViewShowsDecorator) {
        self.viewModel = decorator
    }
}
