//
//  Translate.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

import Foundation

struct Translate {
    
    var key: String
    var value: String
    
    init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
    
    public func getScreenName() -> String {
        var screenName = ""
        if key.starts(with: "common_") {
            screenName = "common"
        } else if key.contains("_screen") {
            screenName = key.components(separatedBy: "_screen_").first!
        } else {
            print("Invalid format.")
        }
        return screenName
    }
    
    public func getAttributeName() -> String {
        var screenName = ""
        if key.starts(with: "common") {
            screenName = key.components(separatedBy: "common_").last!
        } else if key.contains("_screen") {
            screenName = key.components(separatedBy: "_screen_").last!
        } else {
            print("Invalid format.")
        }
        return screenName
    }
}
