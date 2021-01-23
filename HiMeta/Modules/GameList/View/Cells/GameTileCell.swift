//
//  GameTileCell.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import UIKit
import SDWebImage

final class GameTileCell: UICollectionViewCell {
    @IBOutlet private weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet private weak var artworkImageView: UIImageView! {
        didSet {
            artworkImageView.layer.cornerRadius = 6.0
            let gradientMaskLayer: CAGradientLayer = CAGradientLayer()
            gradientMaskLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 55)
            gradientMaskLayer.colors = [MetafyStyle.color.background.cgColor,
                                        UIColor.clear.cgColor]
            gradientMaskLayer.locations = [0.0, 1.0]
            artworkImageView.layer.mask = gradientMaskLayer
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MetafyStyle.font.bodySemiBold
            titleLabel.textColor = .white
        }
    }
    @IBOutlet private weak var coachesLabel: UILabel! {
        didSet {
            coachesLabel.layer.cornerRadius = 5.0
            coachesLabel.layer.borderWidth = 1.0
            coachesLabel.layer.borderColor = MetafyStyle.color.stone.cgColor
            coachesLabel.font = MetafyStyle.font.captionTwoRegular
            coachesLabel.textColor = .white
        }
    }
    @IBOutlet private weak var lessonsLabel: UILabel! {
        didSet {
            lessonsLabel.layer.cornerRadius = 5.0
            lessonsLabel.layer.borderWidth = 1.0
            lessonsLabel.layer.borderColor = MetafyStyle.color.stone.cgColor
            lessonsLabel.font = MetafyStyle.font.captionTwoRegular
            lessonsLabel.textColor = .white
        }
    }
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = MetafyStyle.color.background
            containerView.layer.cornerRadius = 10.0
        }
    }
    
    func update(with item: AnyObject?) {
        guard let gameTile = item as? GameTile else { return }
        titleLabel.text = gameTile.title
        coachesLabel.text = "\(gameTile.coachCount) Coaches"
        lessonsLabel.text = "\(gameTile.lessonCount) Lessons"
        posterImageView.sd_setImage(with: URL(string: gameTile.poster))
        artworkImageView.sd_setImage(with: URL(string: gameTile.artwork))
    }
}
