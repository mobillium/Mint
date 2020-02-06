//
//  MintError.swift
//  Mint
//
//  Created by Mustafa GUNES on 6.02.2020.
//  Copyright © 2020 Mustafa GUNES. All rights reserved.
//

enum ANSIColors: String {
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case white = "\u{001B}[0;37m"
}

import Foundation

enum MintError: LocalizedError {
    case customMessage(String)

    var errorDescription: String? {
        switch self {
            
        case .customMessage(let message):
            return message
        }
    }
}
