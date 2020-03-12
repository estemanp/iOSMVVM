//
//  Constants.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

struct CatDetailConstant {
    static let Title = "Breed Details"
    static let noWiki = "The wikipedia url is not available"
}

struct CatDashboardConstant {
    static let Title = "Dashboard"
}

struct CatListConstant {
    static let Title = "Cat breed"
    
    struct BarItem {
        static let refresh = "Refresh"
    }
    
    struct Cell {
        static let Identifier = "CatCell"
    }
    
    struct ErrorMessages {
        static let NoDataFound = "No data found"
    }
}

struct CatAPIServiceConstant {
    static let apiHeader = "x-api-key"
    static let apiKey = "737c55b0-0a92-4c0f-b10a-26c07276877e"
    static let contentType = "Content-Type"
    static let contentTypeJSON = "application/json"
    static let parameterOffset = "page"
    static let parameterLimit = "limit"
    static let parameterIDBreed = "breed_id"
    static let parameterVote = "value"
    static let parameterIdImage = "image_id"
    static let parameterIdUser = "sub_id"
    static let userId = "CondorLabsUser0001"

}
