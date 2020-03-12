//
//  TypeAlias.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]
public typealias HTTPHeaders = [String:String]
public typealias TypeFetchData = [ViewType:(())]
public typealias APIServiceCompletion = (_ data:Data?, _ reponse:URLResponse?, _ error:Error?) -> ()
