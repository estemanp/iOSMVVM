//
//  VoteCat.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

class VoteCat: Codable {
    
    var id: Int?
    var image: String?
    var userId: String?
    var value: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image = "image_id"
        case userId = "sub_id"
        case value
    }
}
