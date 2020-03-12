//
//  CatRequestEndPoint.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

public enum CatRequestEndPoint: RequestEndPointProtocol {
    
    case catBreedList(offset:Int, limit:Int)
    case catBreedImage(idBreed: String)
    case voteCat(idImage: String, vote: Int)
    case yourVotes(offset:Int, limit:Int)
    case favoriteCat(idImage: String)
    case yourFavorites(offset:Int, limit:Int)

    var baseURL: URL{
        switch self {
        case .catBreedList, .catBreedImage, .voteCat, .yourVotes, .favoriteCat, .yourFavorites:
            guard let url = URL(string: "https://api.thecatapi.com/v1/")else{
                fatalError("Base Url could not be configured")
            }
            return url
        }
    }
    
    var path: String{
        switch self {
        case .catBreedList:
            return("breeds")
        case .catBreedImage:
            return ("images/search")
        case .voteCat, .yourVotes:
            return ("votes")
        case .favoriteCat, .yourFavorites:
            return ("favourites")
        }
    }
    
    var httpMethod: HTTPMethod{
        switch self {
        case .catBreedList, .catBreedImage, .yourVotes, .yourFavorites:
            return HTTPMethod.get
        case .voteCat, .favoriteCat:
            return HTTPMethod.post
        }
    }
    
    var httpHeaders: HTTPHeaders{
        return [CatAPIServiceConstant.contentType:CatAPIServiceConstant.contentTypeJSON, CatAPIServiceConstant.apiHeader:CatAPIServiceConstant.apiKey]
    }
    
    var parameters: ParameterEncoding{
        switch self {
        case .catBreedList(let offset, let limit):
            return ParameterEncoding.url(parameter: [CatAPIServiceConstant.parameterOffset:offset, CatAPIServiceConstant.parameterLimit:limit])
        case .catBreedImage(let idBreed):
            return ParameterEncoding.url(parameter: [CatAPIServiceConstant.parameterIDBreed:idBreed])
        case .voteCat(let idImage, let vote):
            return ParameterEncoding.body(parameter: [CatAPIServiceConstant.parameterIdImage: idImage, CatAPIServiceConstant.parameterVote: vote, CatAPIServiceConstant.parameterIdUser: CatAPIServiceConstant.userId])
        case .yourVotes(let offset, let limit):
            return ParameterEncoding.url(parameter: [CatAPIServiceConstant.parameterIdUser: CatAPIServiceConstant.userId,CatAPIServiceConstant.parameterOffset:offset, CatAPIServiceConstant.parameterLimit:limit])
        case .favoriteCat(let idImage):
            return ParameterEncoding.body(parameter: [CatAPIServiceConstant.parameterIdImage: idImage, CatAPIServiceConstant.parameterIdUser: CatAPIServiceConstant.userId])
        case .yourFavorites(let offset, let limit):
            return ParameterEncoding.url(parameter: [CatAPIServiceConstant.parameterIdUser: CatAPIServiceConstant.userId, CatAPIServiceConstant.parameterOffset:offset, CatAPIServiceConstant.parameterLimit:limit])
        }
    }
}
