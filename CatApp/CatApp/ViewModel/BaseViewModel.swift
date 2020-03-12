//
//  BaseViewModel.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation
import Reachability

public class BaseViewModel {
    
    func checkInternet() -> Bool{
        guard let reachability = Reachability() else {
            return false
        }
        return reachability.connection == .none ? false : true
    }
    
    func checkResponse(response: URLResponse) -> Bool{
        print(response)
        guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        return false
        }
        return true
    }
}
