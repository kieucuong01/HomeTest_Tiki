//
//  HotKeyModel.swift
//  HomeTest-iOS
//
//  Created by KTC on 8/29/18.
//  Copyright © 2018 KTC. All rights reserved.
//

import UIKit

class HotKeyModel: NSObject {
    var keyWord : String = ""
    var iconURLString : String = ""
    
    init(keyword: String, iconURLString: String){
        self.keyWord = keyword
        self.iconURLString = iconURLString
    }

    init(dict:NSDictionary) {
        if let keyWord = dict["keyword"] as? String {
            self.keyWord = keyWord
        } else {
            self.keyWord = ""
        }
        
        if let iconURLString = dict["icon"] as? String {
            self.iconURLString = iconURLString
        } else {
            self.iconURLString = ""
        }
    }
}
