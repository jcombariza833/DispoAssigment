//
//  GiphyAPIService.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/28/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import ComposableArchitecture

enum NetworkError: Error, Equatable {
    case unableToRequest
}

protocol GiphyAPIService {
    func fetchTrendingGifs() -> Effect<GroupResponse,NetworkError>
    func fetchGifs(by searchText: String) -> Effect<GroupResponse,NetworkError>
    func getGifDetail(by id: String) -> Effect<Response,NetworkError>
}
