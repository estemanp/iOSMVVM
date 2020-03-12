//
//  RequestEndPoint.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

protocol RequestEndPointProtocol {
    
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeaders { get }
    var parameters: ParameterEncoding { get }
}
