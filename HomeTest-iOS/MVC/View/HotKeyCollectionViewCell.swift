//
//  HotKeyCollectionViewCell.swift
//  HomeTest-iOS
//
//  Created by KTC on 8/29/18.
//  Copyright © 2018 KTC. All rights reserved.
//

import UIKit
import AlamofireImage

class HotKeyCollectionViewCell: UICollectionViewCell {
    static var HOT_KEY_NIB_NAME = "HotKeyCollectionViewCell"
    static var HOT_KEY_IDENTIFIER = "HotKeyCollectionViewCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var keywordView: UIView!
    var model : HotKeyModel? = nil
    var isHeightCalculated: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.keywordView.layer.cornerRadius = 7 * AppUtil.displayScale
        self.keywordLabel.font = UIFont.systemFont(ofSize: 14 * AppUtil.displayScale)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
    func updateViewCell(model: HotKeyModel, keywordColor: UIColor) {
        self.model = model
        if AppUtil.getNumberOfWord(text: model.keyWord) == 1 {
            self.keywordLabel.numberOfLines = 1
        }
        else {
            self.keywordLabel.numberOfLines = 2
        }
        
        self.keywordLabel.text = model.keyWord
        self.keywordView.backgroundColor = keywordColor
        
        if let urlImage = URL(string: model.iconURLString) {
            self.iconImageView.af_setImage(withURL: urlImage,
                                               placeholderImage: nil,
                                               filter: nil,
                                               imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
                                               runImageTransitionIfCached: false,
                                               completion: nil)
        }
        else {
            self.iconImageView.image = nil
        }
    }
}
