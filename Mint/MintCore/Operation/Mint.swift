//
//  Mint.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

import Foundation

class Mint {
    
    /// Mint: Is the function from which the application is started. It needs commandline arguments.
    /// - Parameter rawArguments: Commandline Arguments
    static func run(withArguments rawArguments: [String]) throws {
        guard let arguments = CommandlineParser.parse(arguments: rawArguments) else {
            throw MintError.customMessage(ANSIColors.red.rawValue + "Usage: -i <path to Localizable.strings file> -o <path including file name to write Swift to>")
        }

        guard FileHandler.readFile(from: arguments) != nil else {
            throw MintError.customMessage(ANSIColors.red.rawValue + "Couldn't read files. Did you type your arguments incorrectly?")
        }

        try FileHandler.writeOutput(outputString: Mint.generateInputs(path: arguments), to: arguments)
    }
    
    /// Mint: Reads the file. Parses according to patterns. The code is output in the generator.
    /// - Parameter path: Commandline Arguments. (inputURL, outputURL). URL type.
    /// - Returns: The output of the milled code reverts to the String type.
    static func generateInputs(path: Commandline) throws -> String {
        
        guard let content = FileHandler.readFile(from: path)?.input else {
            throw MintError.customMessage(ANSIColors.red.rawValue + "The file could not be read")
        }
        
        let lines = content.components(separatedBy: CharacterSet.newlines)
        let results = content.match(PATTERN)

        let keyValues: [Translate] = Mint.translateModel(outputPattern: results)
        let dictionary = Mint.parsedDictionary(values: keyValues)
        
        #if DEBUG
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
        #endif
        
        let output = OutputGenerator()
        output.append("public struct Localizations {", newLineCount: 2)
        for screen in dictionary {
            output.append(screen.key, screen.value)
        }
        output.append("}")
        return output.content
    }
    
    /// Mint: It needs text writing parsed by pattern. Creates a translation sequence.
    /// - Parameter outputPattern: Parsed String output.
    /// - Returns: Returned translate model array
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
    
    /// Creates a dictionary by taking a translation sequence.
    /// - Parameter values: Translate model array
    /// - Returns: Returned Dictionary array
    static func parsedDictionary(values: [Translate]) -> [(key: String, value: [Translate])] {
        let dictionary = Dictionary(grouping: values, by: { $0.getScreenName() }).sorted(by: {
            if $0.key == "Common" { return true }
            if $1.key == "Common" { return false }
            return $0.key < $1.key
        })
        return dictionary
    }
}
