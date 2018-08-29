//
//  RecentKeyCollectionViewCell.swift
//  HomeTest-iOS
//
//  Created by KTC on 8/29/18.
//  Copyright © 2018 KTC. All rights reserved.
//

import UIKit

class RecentKeyCollectionViewCell: UICollectionViewCell {
    static var RECENT_KEY_NIB_NAME = "RecentKeyCollectionViewCell"
    static var RECENT_KEY_IDENTIFIER = "RecentKeyCollectionViewCell"
    
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var backgroundKeywordView: UIView!
    
    var model : RecentKeyModel?
    var isHeightCalculated: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        self.keywordLabel.font = UIFont.systemFont(ofSize: 14 * AppUtil.displayScale)
        self.backgroundKeywordView.layer.cornerRadius = 7 * AppUtil.displayScale
        // Initialization code
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


    func updateViewCell(model: RecentKeyModel, keywordBackgroundColor: UIColor) {
        self.model = model
        if AppUtil.getNumberOfWord(text: model.keyWord) == 1 {
            self.keywordLabel.numberOfLines = 1
        }
        else {
            self.keywordLabel.numberOfLines = 2
        }
        self.keywordLabel.text = model.keyWord
        self.backgroundKeywordView.backgroundColor = keywordBackgroundColor
    }
}
