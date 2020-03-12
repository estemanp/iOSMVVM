//
//  URLBodyEncoding.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

struct URLBodyEncoding: ParameterEncodingProtocol {
    
    func encode(urlRequest: inout URLRequest, parameters: Parameters) throws {
        guard let url = urlRequest.url else{
           throw(NetworkErrors.missingURL)
        }
        
        if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty{
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            urlRequest.httpBody = httpBody
            urlRequest.url = urlComponents.url
        }
    }
}
