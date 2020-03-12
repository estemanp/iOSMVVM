//
//  FavoriteCat.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

class FavoriteCat: Codable {
    
    var id: Int?
    var image: CatImage?
    var userId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case userId = "sub_id"
    }
}
