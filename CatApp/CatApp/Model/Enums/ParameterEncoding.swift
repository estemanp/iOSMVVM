//
//  ParameterEncoding.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

public enum ParameterEncoding{
    
    case none
    case body(parameter : Parameters?)
    case url(parameter : Parameters?)
    
    func encode(urlReqeuest: inout URLRequest) throws {
        do{
            switch self {
            case .none:
                return
            case .url(let parameter):
                guard let parameter = parameter else{ return }
                try URLParameterEncoding().encode(urlRequest: &urlReqeuest, parameters: parameter)
            case .body(let parameter):
                guard let parameter = parameter else{ return }
                try URLBodyEncoding().encode(urlRequest: &urlReqeuest, parameters: parameter)
            }
        }catch{
            throw error
        }
    }
}
