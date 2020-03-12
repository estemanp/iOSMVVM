//
//  URLSessionAPIService.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation

class URLSessionAPIService: APIServiceProtocol {
    
    private var task: URLSessionTask?
    private let timeOut: Double = 10.0
    
    func dispatch(apiRequest: RequestEndPointProtocol, completion: @escaping APIServiceCompletion) {
        let urlSession = URLSession.shared
        do{
            var urlRequest = try self.buildURLRequest(request: apiRequest)
            addHeaders(urlRequest: &urlRequest, httpHeaders: apiRequest.httpHeaders)
            task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        }catch{
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    private func buildURLRequest(request: RequestEndPointProtocol) throws -> URLRequest{
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeOut)
        urlRequest.httpMethod = request.httpMethod.rawValue
        try request.parameters.encode(urlReqeuest: &urlRequest)
        return urlRequest
    }
    
    private func addHeaders(urlRequest: inout URLRequest, httpHeaders:HTTPHeaders?){
        guard let headers = httpHeaders else{
            return
        }
        for (key, value) in headers{
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
    }
}
