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
            try swift.write(to: URL(string: "file:///Users/mustafagunes/Desktop/PROJELER/Mint/Mint/Resource/Generated.swift")!, atomically: true, encoding: .utf8)
        }

        try doWrite()
//        if let fileData = readFile() {
//            // Only write if there was a change
//            if existingSwift != swift {
//                try doWrite()
//            }
//        } else {
//            try doWrite()
//        }
    }
}
