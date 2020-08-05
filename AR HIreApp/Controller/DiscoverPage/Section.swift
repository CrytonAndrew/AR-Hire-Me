//
//  Section.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/08/05.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [Person]
}
