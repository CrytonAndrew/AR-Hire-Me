//
//  Bundle-Decodable.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/08/05.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url  = self.url(forResource: file, withExtension: nil)
            else {
                fatalError("Failed to locate \(file) in bundle")
            
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) frim bundle")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
