//
//  CatBreedListViewModelProtocol.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

protocol CatBreedListViewModelProtocol {
    
    var sizeCats:Dynamic<Int> { get }
    var isDataLoading:Dynamic<Bool> { get }
    var error:Dynamic<String> { get }
    
    func getCellCatBreedDetail(atIndex indexpath:IndexPath) -> CatBreedDetailCell
    func getCellFavoriteDetail(atIndex indexpath: IndexPath) -> CatBreedDetailCell
    func getCellVoteDetail(atIndex indexpath: IndexPath) -> CatBreedDetailCell
    func getSelectedCatBreedDetail(atIndex indexpath:IndexPath) -> CatBreed
    func fetchCatBreedList(viewType: ViewType)
    func fetchMoreCatBreed(viewType: ViewType)
    func refreshCatBreedList(viewType: ViewType)
}
