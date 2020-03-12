//
//  CatBreed.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

struct CatBreed: Codable {
    
    var id: String?
    var name: String?
    var description: String?
    var image: CatImage?
    var wikipediaUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image
        case wikipediaUrl = "wikipedia_url"
    }
    
}
