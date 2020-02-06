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
        let lines = content.components(separatedBy: CharacterSet.newlines)
        let results = content.match(PATTERN)
        
        Logger.log(title: "CONTENTS", output: content)
        Logger.log(title: "LINES", output: lines)
        Logger.log(title: "RESULTS", output: results)
        
        let keyValues: [Translate] = Mint.translateModel(outputPattern: results)
        let parsedDictionary: [String: [String: String]] = Mint.parsedDictionary(values: keyValues)
        
        do {
            try FileHandler.writeOutput(swift: Generator.generate(keyValues: parsedDictionary))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func translateModel(outputPattern: [[String]]) -> [Translate] {
        var values: [Translate] = []
        for result in outputPattern {
            let key = result[1]
            let value = result[2]
            let translate = Translate(key, value)
            values.append(translate)
        }
        return values
    }
    
    static func parsedDictionary(values: [Translate]) -> [String: [String: String]] {
        var dict: [String: [String: String]] = [:]
        for keyValue in values {
            let screenName = keyValue.getScreenName()
            let attributeName = keyValue.getAttributeName()
            let value = keyValue.value
            
            if dict[screenName] == nil {
                dict[screenName] = [:]
            }
            
            dict[screenName]![attributeName] = value
            Logger.log(title: "MAPPEDKEYS", output: dict)
        }
        return dict
    }
}
