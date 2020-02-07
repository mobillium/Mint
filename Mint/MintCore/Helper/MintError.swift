//
//  MintError.swift
//  Mint
//
//  Created by Mustafa GUNES on 6.02.2020.
//  Copyright © 2020 Mustafa GUNES. All rights reserved.
//

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
