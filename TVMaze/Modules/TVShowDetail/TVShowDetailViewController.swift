//
//  TVShowDetailViewController.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import UIKit
import RxSwift
import SDWebImage
import Lottie

final class TVShowDetailViewController: UIViewController, ViewControllerProtocol {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var resumeLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var likeButton: AnimatedButton!
    
    @IBOutlet weak var mdbmButton: UIButton!
    @IBOutlet weak var bottomDBDMButton: UIView!
    
    
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
        configureLikeButton()
        configureIMDBButton()
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
        
        viewModel.idbmIsHidden.bind(to: mdbmButton.rx.isHidden).disposed(by: disposeBag)
        viewModel.idbmIsHidden.bind(to: bottomDBDMButton.rx.isHidden).disposed(by: disposeBag)
    }
    
    private func configureLikeButton()  {
        likeButton.animation = Animation.named("like")
        likeButton.clipsToBounds = false

        likeButton.setPlayRange(fromMarker: "touchDownStart",
                                   toMarker: "touchDownEnd",
                                   event: .touchDown)

        likeButton.setPlayRange(fromMarker: "touchDownEnd",
                                   toMarker: "touchUpCancel",
                                   event: .touchUpOutside)

        likeButton.setPlayRange(fromMarker: "touchDownEnd",
                                   toMarker: "touchUpEnd",
                                   event: .touchUpInside)
        
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    }
    
    private func configureIMDBButton() {
        mdbmButton.tintColor = .primary
        bottomDBDMButton.backgroundColor = .primary
        mdbmButton.rx.tap.subscribe(viewModel.idbm).disposed(by: disposeBag)
    }
    
    @objc private func likeAction() {
        
    }
}

extension TVShowDetailViewController {
    func configure(with viewModel: TVShowDetailViewModel) {
        self.viewModel = viewModel
    }
}
