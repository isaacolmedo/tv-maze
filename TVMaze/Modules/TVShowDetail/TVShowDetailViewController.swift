//
//  TVShowDetailViewController.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import UIKit
import RxSwift
import SDWebImage

final class TVShowDetailViewController: UIViewController, ViewControllerProtocol {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var resumeLabel: UILabel!
    
    @IBOutlet private weak var closeButton: UIButton!
    
    
    private var viewModel: TVShowDetailViewModel!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverImageView.layer.cornerRadius = 20.0
        coverImageView.layer.shadowColor = UIColor.lightGray.cgColor//UIColor.primary.withAlphaComponent(0.5).cgColor
        coverImageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        coverImageView.layer.shadowRadius = 7.0
        coverImageView.layer.shadowOpacity = 0.5
        coverImageView.layer.shadowOffset = CGSize(width:5, height: 5)
        binds()
    }
    
    func binds() {
        viewModel.imageURL.subscribe { url in
            self.coverImageView.sd_setImage(with: url)
        }.disposed(by: disposeBag)
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.resume.bind(to: resumeLabel.rx.attributedText).disposed(by: disposeBag)
        
        closeButton.rx.tap.subscribe { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
}

extension TVShowDetailViewController {
    func configure(with viewModel: TVShowDetailViewModel) {
        self.viewModel = viewModel
    }
}
