//
//  ViewType.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

public enum ViewType {
    case breed
    case favorite
    case votes
    
    var title: String{
        switch self {
        case .breed:
            return "Breeds"
        case .favorite:
            return "Favorite"
        case .votes:
            return "My votes"
        }
    }
}
