//
//  Logger.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

class Logger {
    
    
    /// Mint: Debug outputs.
    /// - Parameters:
    ///   - title: Needs title. Optional
    ///   - output: Needs output. Required
    static func log(title: Any? = nil, output: Any) {
        if let title = title {
            print(title, ":", output)
            return
        }
        print(output)
    }
}
