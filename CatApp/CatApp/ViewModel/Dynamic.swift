//
//  Dynamic.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

class Dynamic<T>{
    
    typealias Listener = (T) -> ()
    
    var listeners: [Listener] = []
    
    var value:T {
        didSet{
            listeners.forEach{ $0(value)}
        }
    }
    
    init(_ v:T) {
        value = v
    }
    
    func bind(_ listener: @escaping Listener){
        listeners.append(listener)
    }
}
