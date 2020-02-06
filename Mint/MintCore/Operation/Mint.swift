//
//  Mint.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

import Foundation

class Mint {
    
    static func run(withArguments rawArguments: [String]) throws {
        guard let arguments = CommandlineParser.parse(arguments: rawArguments) else {
            throw MintError.customMessage("Usage: -i <path to Localizable.strings file> -o <path including file name to write Swift to>")
        }

        guard FileHandler.readFile(from: arguments) != nil else {
            throw MintError.customMessage("Couldn't read files. Did you type your arguments incorrectly?")
        }

        try FileHandler.writeOutput(outputString: Mint.generateInputs(path: arguments), to: arguments)
    }
    
    static func generateInputs(path: Commandline) throws -> String {
        
        guard let content = FileHandler.readFile(from: path)?.input else {
            throw MintError.customMessage("The file could not be read")
        }
        
        let lines = content.components(separatedBy: CharacterSet.newlines)
        let results = content.match(PATTERN)

        let keyValues: [Translate] = Mint.translateModel(outputPattern: results)
        let dictionary = Mint.parsedDictionary(values: keyValues)
        
        Logger.log(title: "CONTENTS", output: content)
        Logger.log(title: "LINES", output: lines)
        Logger.log(title: "RESULTS", output: results)
        Logger.log(title: "dictionary", output: dictionary)

        for screen in dictionary {
            Logger.log(title: nil, output: "- " + screen.key)
            for translate in screen.value {
                Logger.log(output: "-- " +  translate.getAttributeName())
            }
        }
        
        let output = OutputGenerator()
        output.append("public struct Localizations {", newLineCount: 2)
        for screen in dictionary {
            output.append(screen.key, screen.value)
        }
        output.append("}")
        return output.content
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
    
    static func parsedDictionary(values: [Translate]) -> [(key: String, value: [Translate])] {
        let dictionary = Dictionary(grouping: values, by: { $0.getScreenName() }).sorted(by: {
            if $0.key == "Common" { return true }
            if $1.key == "Common" { return false }
            return $0.key < $1.key
        })
        return dictionary
    }
}
