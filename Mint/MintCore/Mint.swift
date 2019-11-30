//
//  Mint.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

import Foundation

class Mint {
    
    static func run() throws {
        
        let content = FileHandler.readFile()
        Logger.log(title: "CONTENTS", output: content)
        
        let lines = content.components(separatedBy: CharacterSet.newlines)
        Logger.log(title: "LINES", output: lines)
        
        let results = content.match(PATTERN)
        Logger.log(title: "RESULTS", output: results)

        var keyValues: [Translate] = [];
        for result in results {
            let key = result[1]
            let value = result[2]
            let translate = Translate(key, value)
            keyValues.append(translate)
        }

        var mapped: [String: [String: String]] = [:]
        for keyValue in keyValues {
            let screenName = keyValue.getScreenName()
            let attributeName = keyValue.getAttributeName()
            let value = keyValue.value
            if mapped[screenName] == nil {
                mapped[screenName] = [:]
            }
            
            mapped[screenName]![attributeName] = value
            Logger.log(title: "MAPPEDKEYS", output: mapped)
        }

        for map in mapped {
            Logger.log(title: nil, output: "- " + map.key)
            for map2 in map.value {
                Logger.log(title: nil, output: "-- " + map2.value)
            }
        }
    }
}
