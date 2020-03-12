//
//  NetworkErrors.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

public enum NetworkErrors: String, Error{
    
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter Encoding Failed"
    case missingURL = "URL is nil"
    case notNetwork = "Check your internet connection"
    case statusCode = "we are having problems, please try again"
    
}
