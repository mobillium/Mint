//
//  CommandlineParser.swift
//  Mint
//
//  Created by Mustafa GUNES on 6.02.2020.
//  Copyright © 2020 Mustafa GUNES. All rights reserved.
//

import Foundation

struct Commandline {
    let inputURL: URL
    let outputURL: URL
}

struct CommandlineParser {
    
    /// Mint: Reads Commandline arguments.
    /// - Parameter arguments: Commandline Arguments
    /// Return: return Commandline model
    static func parse(arguments: [String]) -> Commandline? {
        let lowercaseArguments = arguments.map({ $0.lowercased() })
        guard let inputCommandIndex = lowercaseArguments.firstIndex(of: "-i"),
              let outputCommandIndex = lowercaseArguments.firstIndex(of: "-o"),
              inputCommandIndex <= arguments.count - 2, outputCommandIndex <= arguments.count - 2,
              inputCommandIndex + 1 != outputCommandIndex, outputCommandIndex + 1 != inputCommandIndex
        else { return nil }

        let inputURLString = arguments[inputCommandIndex + 1]
        let outputURLString = arguments[outputCommandIndex + 1]

        let inputURL = URL(fileURLWithPath: inputURLString)
        let outputURL = URL(fileURLWithPath: outputURLString)
        return Commandline(inputURL: inputURL, outputURL: outputURL)
    }
}
