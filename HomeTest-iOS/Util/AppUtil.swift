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
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
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

    
    static func getStringDateFromTime(time: Double?, with formatDate: String) -> String {
        if let miliseconds: Double = time {
            let seconds: Double = miliseconds / 1000.0
            let date: Date = Date(timeIntervalSince1970: seconds)
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = formatDate
            return formatter.string(from: date)
        }
        else { return "-" }
    }
    
}
