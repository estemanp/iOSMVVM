//
//  CatBreedDetailViewModel.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

class CatBreedDetailViewModel: BaseViewModel, CatBreedDetailViewModelProtocol {
    
    //MARK: Public vars
    var catBreed : Dynamic<CatBreed>
    var isDataLoading: Dynamic<Bool>
    var error: Dynamic<String>
    var showSummary: Dynamic<Bool>
    var isfavorite: Dynamic<Bool>
    
    //MARK: Private vars
    private var apiService = URLSessionAPIService()
    
    
    init(catBreed: CatBreed){
        self.catBreed = Dynamic(catBreed)
        isDataLoading = Dynamic(false)
        error = Dynamic("")
        isfavorite = Dynamic(false)
        showSummary = Dynamic(false)
        super.init()
    }
    
    func fetchImageUrl() {
        if checkInternet() {
            if let idBreed = catBreed.value.id{
                isDataLoading.value = true
                apiService.dispatch(apiRequest: CatRequestEndPoint.catBreedImage(idBreed: idBreed)) { (data, response, error) in
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
                        self.proccessDataImageUrl(data: data)
                    }
                    self.isDataLoading.value = false
                }
            }else{
                self.error.value = NetworkErrors.parametersNil.rawValue
            }
        }else{
            self.error.value = NetworkErrors.notNetwork.rawValue
        }
    }
    
    func voteCatBreed(inFavor: Bool) {
        if checkInternet() {
            isDataLoading.value = true
            if let idImage = catBreed.value.image?.id{
                apiService.dispatch(apiRequest: CatRequestEndPoint.voteCat(idImage: idImage, vote: NSNumber(booleanLiteral: inFavor).intValue)) { (data, response, error) in
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
                        self.showSummary.value = true
                        let myData = String(data: data, encoding: String.Encoding.utf8)
                        print(myData ?? "")
                    }
                    self.isDataLoading.value = false
                }
            }
        }else{
            self.error.value = NetworkErrors.notNetwork.rawValue
        }
    }
    
    func changeFavorite(){
        if !isfavorite.value{
            if checkInternet() {
                isDataLoading.value = true
                if let idImage = catBreed.value.image?.id{
                    apiService.dispatch(apiRequest: CatRequestEndPoint.favoriteCat(idImage: idImage)) { (data, response, error) in
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
                            self.isfavorite.value = true
                            let myData = String(data: data, encoding: String.Encoding.utf8)
                            print(myData ?? "")
                        }
                        self.isDataLoading.value = false
                    }
                }
            }else{
                self.error.value = NetworkErrors.notNetwork.rawValue
            }
        }
    }
    
    private func proccessDataImageUrl(data: Data){
        do {
            let myData = String(data: data, encoding: String.Encoding.utf8)
            print(myData ?? "")
            let catImages = try JSONDecoder().decode([CatImage].self, from: data)
            self.catBreed.value.image = catImages.first
        } catch {
            print(error)
            self.error.value = error.localizedDescription
        }
    }
    
}
