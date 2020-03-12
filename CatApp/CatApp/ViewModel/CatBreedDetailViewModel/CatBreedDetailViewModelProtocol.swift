//
//  CatBreedDetailViewModelProtocol.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

protocol CatBreedDetailViewModelProtocol {
    
    var catBreed : Dynamic<CatBreed> { get }
    var isDataLoading:Dynamic<Bool> { get }
    var showSummary:Dynamic<Bool> { get }
    var isfavorite: Dynamic<Bool> { get }
    var error:Dynamic<String> { get }
    
    func fetchImageUrl()
    func voteCatBreed(inFavor: Bool)
    func changeFavorite()
}
