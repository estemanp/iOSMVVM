//
//  CatImage.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

struct CatImage : Codable{
    
    var imageUrl: String?
    var id: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
        case id
    }
}
