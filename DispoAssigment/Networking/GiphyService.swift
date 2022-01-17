//
//  GiphyService.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK

enum GiphySDKError: Error {
    case errorFetchingMedia
}
protocol GiphyService {
    func fetchTrendingGifs() -> AnyPublisher<GroupResponse,AFError>
    func fetchGifs(by searchText: String) -> AnyPublisher<GroupResponse,AFError>
    func getGifInfo(by id: String) -> AnyPublisher<Response,AFError>
    func getGif(by id: String) -> AnyPublisher<GPHMedia,GiphySDKError>
}
