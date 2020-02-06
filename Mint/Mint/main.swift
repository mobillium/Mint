//
//  main.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

import Foundation

do {
    try Mint.run(withArguments: CommandLine.arguments)
} catch {
    fatalError(error.localizedDescription)
}
