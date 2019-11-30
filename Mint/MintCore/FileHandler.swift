//
//  FileHandler.swift
//  Mint
//
//  Created by Mustafa GUNES on 30.11.2019.
//  Copyright © 2019 Mustafa GUNES. All rights reserved.
//

import Foundation

class FileHandler {
    
    static func readFile() -> String {
        let filePath = "Localizable.strings"
        let fileUrl = URL(fileURLWithPath: filePath)
        let content = try! String(contentsOf: fileUrl)
        return content
    }
}
