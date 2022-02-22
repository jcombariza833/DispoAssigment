//
//  GiphiAPIRepository.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/28/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import ComposableArchitecture

struct GiphyAPIRepository: GiphyAPIService {
   
    enum UrlType {
        case trending
        case search(searchTerm: String)
        case gif(id: String)
        
        func getUrl() -> URL {
            let apikey = Constants.giphyApiKey
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.giphy.com"
            components.path = "/v1/gifs/search"
            components.queryItems = [
                           URLQueryItem(name: "api_key", value: apikey)
                       ]
            
            switch self {
            case .trending:
                components.path = "/v1/gifs/trending"
                components.queryItems?.append(URLQueryItem(name: "rating", value: "pg"))
            case .search(let searchTerm):
                components.path = "/v1/gifs/search"
                components.queryItems?.append(URLQueryItem(name: "q", value: searchTerm))
            case .gif(let id):
                components.path = "/v1/gifs/\(id)"
            }
            
            return components.url!
        }
    }
    
    func fetchTrendingGifs() -> Effect<GroupResponse,NetworkError> {
        let url = UrlType.trending.getUrl()
        
        return Future <GroupResponse, NetworkError> { promise in
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: GroupResponse.self) { response in
                    switch response.result {
                    case .success(let gifs):
                        promise(.success(gifs))
                    case .failure( _ ):
                        promise(.failure(.unableToRequest))
                    }
                }
        }.eraseToEffect()
    }
    
    func fetchGifs(by searchText: String) -> Effect<GroupResponse,NetworkError> {
        let url = UrlType.search(searchTerm: searchText).getUrl()
        return Future <GroupResponse, NetworkError> { promise in
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: GroupResponse.self) { response in
                    switch response.result {
                    case .success(let gifs):
                        promise(.success(gifs))
                    case .failure( _ ):
                        promise(.failure(.unableToRequest))
                    }
                }
        }.eraseToEffect()
    }
    
    func getGifDetail(by id: String) -> Effect<Response,NetworkError> {
        let url = UrlType.gif(id: id).getUrl()
        return Future <Response, NetworkError> { promise in
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: Response.self) { response in
                    switch response.result {
                    case .success(let gif):
                        promise(.success(gif))
                    case .failure( _ ):
                        promise(.failure(.unableToRequest))
                    }
                }
        }.eraseToEffect()
    }
}

