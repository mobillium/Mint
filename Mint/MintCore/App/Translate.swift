//
//  Translate.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

import Foundation

public struct Translate {
    
    var key: String
    var value: String
    
    init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
    
    public func getScreenName() -> String {
        var screenName = ""
        if key.starts(with: COMMON_) {
            screenName = COMMON
        } else if key.contains(SCREEN) {
            screenName = key.components(separatedBy: SCREEN).first!
        } else {
            Logger.log(output: "Invalid screen name format.")
            MintError.customMessage("Invalid screen name format.")
        }
        return screenName.split(separator: "_").map({$0.capitalized}).joined()
    }
    
    public func getAttributeName() -> String {
        var attributeName = ""
        if key.starts(with: COMMON) {
            attributeName = key.components(separatedBy: COMMON_).last!
        } else if key.contains(SCREEN) {
            attributeName = key.components(separatedBy: SCREEN).last!
        } else {
            Logger.log(output: "Invalid attribute name format.")
            MintError.customMessage("Invalid screen name format.")
        }
        return attributeName.split(separator: "_").map({$0.capitalized}).joined()
    }
    
    public func hasParameters() -> Bool {
        return !getParameters().isEmpty
    }
    
    public func getParameters() -> [String] {
        return value.match(PARAMETERS).map({$0[1]})
    }
}
