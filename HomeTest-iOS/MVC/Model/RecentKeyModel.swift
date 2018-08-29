//
//  RecentKeyModel.swift
//  HomeTest-iOS
//
//  Created by KTC on 8/29/18.
//  Copyright © 2018 KTC. All rights reserved.
//

import UIKit

class RecentKeyModel: NSObject {
    var keyWord : String = ""
    var searchTime : Date
    
    init(keyword: String, searchTime : Date) {
        self.keyWord = keyword
        self.searchTime = searchTime
    }
}
