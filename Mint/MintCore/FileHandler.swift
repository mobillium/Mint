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
    
    static func writeOutput(swift: String) throws {
        let doWrite = {
            let filePath = URL(string: "file:///Users/mustafagunes/Desktop/PROJELER/Mint/Mint/Resource/Generated.swift")!
            try swift.write(to: filePath, atomically: true, encoding: .utf8)
        }
        try doWrite()
    }
}
