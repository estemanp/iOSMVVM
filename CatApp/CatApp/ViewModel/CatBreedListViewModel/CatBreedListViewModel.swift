//
//  CatBreedListViewModel.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

class CatBreedListViewModel: BaseViewModel, CatBreedListViewModelProtocol {
    
    //MARK: Public vars
    var sizeCats: Dynamic<Int>
    var isDataLoading: Dynamic<Bool>
    var error: Dynamic<String>
    
    //MARK: Private vars
    private var catBreedList:[CatBreed] = []
    private var catBreedListDataSource:[CatBreedDetailCell] = []
    private var favoriteCatList:[FavoriteCat] = []
    private var favoriteCatListDataSource:[CatBreedDetailCell] = []
    private var voteCatList:[VoteCat] = []
    private var voteCatListDataSource:[CatBreedDetailCell] = []
    private var apiService: APIServiceProtocol = URLSessionAPIService()
    private var viewType: ViewType = .breed
    private var apiOffset: Int = 0
    private var apiLimit: Int
    
    private let countItem: Int = 12
    
    override init() {
        sizeCats = Dynamic(0)
        isDataLoading = Dynamic(false)
        error = Dynamic("")
        apiLimit = countItem
        super.init()
    }
    
    func getCellCatBreedDetail(atIndex indexpath: IndexPath) -> CatBreedDetailCell {
        return catBreedListDataSource[indexpath.row]
    }
    
    func getCellFavoriteDetail(atIndex indexpath: IndexPath) -> CatBreedDetailCell {
        return favoriteCatListDataSource[indexpath.row]
    }
    
    func getCellVoteDetail(atIndex indexpath: IndexPath) -> CatBreedDetailCell {
        return voteCatListDataSource[indexpath.row]
    }
    
    func getSelectedCatBreedDetail(atIndex indexpath: IndexPath) -> CatBreed {
        return catBreedList.catBreedList[indexpath.row]
    }
    
    func fetchCatBreedList(viewType: ViewType) {
        if checkInternet() {
            isDataLoading.value = true
            fetchData(viewType: viewType)
        }else{
            self.error.value = NetworkErrors.notNetwork.rawValue
        }
    }
    
    
    func fetchMoreCatBreed(viewType: ViewType) {
        if !isDataLoading.value {
            self.apiOffset += 1
            fetchCatBreedList(viewType: viewType)
        }
    }
    
    func refreshCatBreedList(viewType: ViewType) {
        self.apiOffset = 0
        self.apiLimit = countItem
        self.catBreedList = []
        self.catBreedListDataSource = []
        fetchCatBreedList(viewType: viewType)
    }
    
    
    //MARK: Private methods
    
    private func fetchData(viewType: ViewType){
        self.viewType = viewType
        switch viewType {
        case .breed:
            apiService.dispatch(apiRequest: CatRequestEndPoint.catBreedList(offset: apiOffset, limit: apiLimit), completion: serviceCompletion)
        case .favorite:
            apiService.dispatch(apiRequest: CatRequestEndPoint.yourFavorites(offset: apiOffset, limit: apiLimit), completion: serviceCompletion)
        case .votes:
            apiService.dispatch(apiRequest: CatRequestEndPoint.yourVotes(offset: apiOffset, limit: apiLimit), completion: serviceCompletion)
        }
    }
    
    private func serviceCompletion(data: Data?, response: URLResponse?, error: Error?){
        if let response = response{
            if !self.checkResponse(response: response){
                self.error.value = NetworkErrors.statusCode.rawValue
            }
        }
        if let error = error {
            print(error)
            self.error.value = error.localizedDescription
        }
        if let data = data {
            self.proccessData(data: data)
        }
        self.isDataLoading.value = false
    }
    
    private func proccessData(data: Data){
        do {
            let myData = String(data: data, encoding: String.Encoding.utf8)
            print(myData ?? "")
            try decodeData(data: data)
        } catch {
            print(error)
            self.error.value = error.localizedDescription
        }
    }
    
    private func decodeData(data: Data) throws{
        switch viewType {
        case .breed:
            let catList = try JSONDecoder().decode([CatBreed].self, from: data)
            self.processFetchedCatBreedDetail(catList: catList)
        case .favorite:
            let favoriteList = try JSONDecoder().decode([FavoriteCat].self, from: data)
            self.processFetchedFavoriteCat(catList: favoriteList)
        case .votes:
            let voteList = try JSONDecoder().decode([VoteCat].self, from: data)
            self.processFetchedVoteCat(catList: voteList)
        }
    }
    
    private func processFetchedCatBreedDetail(catList: [CatBreed]){
        if catList.count == 0 {
            self.error.value = CatListConstant.ErrorMessages.NoDataFound
        }else{
            self.catBreedList.append(contentsOf:catList)
            updateCellDataSource(catList)
        }
    }
    
    private func updateCellDataSource(_ catList: [CatBreed]) {
        var cellDataSourceList:[CatBreedDetailCell] = []
        for catDetail in catList{
            let cellDataSource = CatBreedDetailCell(image: catDetail.image?.imageUrl ?? "", name: catDetail.name ?? "")
            cellDataSourceList.append(cellDataSource)
        }
        self.catBreedListDataSource.append(contentsOf:cellDataSourceList)
        self.sizeCats.value = self.catBreedListDataSource.count
    }
    
    private func processFetchedFavoriteCat(catList: [FavoriteCat]){
        if catList.count == 0 {
            self.error.value = CatListConstant.ErrorMessages.NoDataFound
        }else{
            self.favoriteCatList.append(contentsOf:catList)
            updateFavoriteCatCellDataSource(catList)
        }
    }
    
    private func updateFavoriteCatCellDataSource(_ catList: [FavoriteCat]) {
        var cellDataSourceList:[CatBreedDetailCell] = []
        for catDetail in catList{
            let cellDataSource = CatBreedDetailCell(image: catDetail.image?.imageUrl ?? "", name: "Favorite")
            cellDataSourceList.append(cellDataSource)
        }
        self.favoriteCatListDataSource.append(contentsOf:cellDataSourceList)
        self.sizeCats.value = self.favoriteCatListDataSource.count
    }
    
    private func processFetchedVoteCat(catList: [VoteCat]){
        if catList.count == 0 {
            self.error.value = CatListConstant.ErrorMessages.NoDataFound
        }else{
            self.voteCatList.append(contentsOf:catList)
            updateVoteCatCellDataSource(catList)
        }
    }
    
    private func updateVoteCatCellDataSource(_ catList: [VoteCat]) {
        var cellDataSourceList:[CatBreedDetailCell] = []
        for catDetail in catList{
            let value = catDetail.value ?? 0
            let title: String = Bool(truncating: NSNumber(value: value)) ? "You like it" : "You don't like it"
            let cellDataSource = CatBreedDetailCell(image: catDetail.image ?? "", name: title)
            cellDataSourceList.append(cellDataSource)
        }
        self.voteCatListDataSource.append(contentsOf:cellDataSourceList)
        self.sizeCats.value = self.voteCatListDataSource.count
    }
    
}
