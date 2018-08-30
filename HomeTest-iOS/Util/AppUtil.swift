//
//  AppUtil.swift
//  HomeTest-iOS
//
//  Created by KTC on 8/29/18.
//  Copyright © 2018 KTC. All rights reserved.
//

import Foundation
import UIKit

final class AppUtil {
    
    static let screenSize: CGRect = UIScreen.main.bounds
    static let displayScale: CGFloat = UIScreen.main.bounds.width/375.0
    
    static func getNumberOfWord(text: String) -> Int {
        let chararacterSet = CharacterSet.whitespacesAndNewlines
        let components = text.components(separatedBy: chararacterSet)
        let words = components.filter { !$0.isEmpty }
        return words.count
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // Width of content collection view cell
    static func caculateWidthForCollectionCell(keyword: String) -> CGFloat {
        if AppUtil.getNumberOfWord(text: keyword) == 1 {
            let widthKeyword : CGFloat = keyword.width(font: UIFont.systemFont(ofSize: 14 * AppUtil.displayScale))
            return widthKeyword
        }
        else {
            let chars = Array(keyword)
            var newLinePosition : Int = 0
            for i in chars.count/2...chars.count{
                if chars[i] == Character.init(" ") {
                    newLinePosition = i
                    break;
                }
            }
            let line1String = keyword.prefix(newLinePosition)
            let widthKeyword : CGFloat = String(line1String).width(font: UIFont.systemFont(ofSize: 14 * AppUtil.displayScale))
            return widthKeyword
        }
    }
}
