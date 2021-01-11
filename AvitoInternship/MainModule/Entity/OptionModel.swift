//
//  OptionModel.swift
//  AvitoInternship
//
//  Created by Artemiy Platonov on 10.01.2021.
//  Copyright © 2021 Artemiy Platonov. All rights reserved.
//

import Foundation

struct Stat: Codable {
    let status: String
    let result: Res
}

struct Res: Codable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [Option]
}

struct Option: Codable {
    var id: String
    var title: String
    var description: String?
    var icon: [String:String]
    var image: Data?
    var price: String
    var isSelected: Bool
}



