//
//  TVShowItemTableViewCell.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import UIKit
import Lottie
import RxSwift

protocol TVShowItemTableViewCellDataSource {
    var id: Int { get }
    var title: String { get }
    var url: URL { get }
    var isFavorite: Bool  { get }
}

final class TVShowItemTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var likeButton: AnimatedButton!
    @IBOutlet private weak var shadowView: UIView!
    
    private let endAnimationFrame: CGFloat = 116.0
    private var id: Int = 0
    private var isLikeButtonOn = false {
        willSet {
            guard newValue else {
                DispatchQueue.main.async { self.likeButton.animationView.stop() }
                return
            }
            DispatchQueue.main.async { self.likeButton.animationView.play() }
        }
    }
    
    var didLikeAction: PublishSubject<(Bool, Int)> = PublishSubject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
        shadowView.setCardView()
        coverImageView.setCardView()
    }
    
    private func configureButton() {
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
    
    @objc private func likeAction() {
        isLikeButtonOn.toggle()
        didLikeAction.onNext((isLikeButtonOn, id))
    }
    
    private func setEndAnimation() {
        likeButton.animationView.play(fromFrame: endAnimationFrame,
                                           toFrame: endAnimationFrame,
                                           loopMode: .none,
                                           completion: nil)
    }
}

extension TVShowItemTableViewCell {
    func removeLikeButton() {
        likeButton.isHidden = true
    }

    func configure(with dataSource: TVShowItemTableViewCellDataSource) {
        isLikeButtonOn = dataSource.isFavorite
        id = dataSource.id
        titleLabel.text = dataSource.title
        coverImageView.sd_setImage(with: dataSource.url) { [weak self] (_, _, _, _) in
            guard let self = self else { return }
            self.setNeedsUpdateConstraints()
        }
    }
}

extension UIView {

    func setCardView(){
//        layer.cornerRadius = 5.0
//        layer.borderColor  =  UIColor.clear.cgColor
//        layer.borderWidth = 5.0
//        layer.shadowOpacity = 0.5
//        layer.shadowColor =  UIColor.lightGray.cgColor
//        layer.shadowRadius = 5.0
//        layer.shadowOffset = CGSize(width:5, height: 5)
//        layer.masksToBounds = true
//
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.lightGray.cgColor//UIColor.primary.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width:5, height: 5)
    }
}
