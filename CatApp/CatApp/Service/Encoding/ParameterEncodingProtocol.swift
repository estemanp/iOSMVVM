//
//  ParameterEncodingProtocol.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

protocol ParameterEncodingProtocol {
    
    func encode(urlRequest: inout URLRequest, parameters:Parameters) throws

}
