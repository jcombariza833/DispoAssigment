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
import ComposableArchitecture

protocol GiphyService {
    func fetchTrendingGifs() -> Effect<GroupResponse,AFError>
    func fetchGifs(by searchText: String) -> Effect<GroupResponse,AFError>
    func getGifInfo(by id: String) -> Effect<Response,AFError>
    func getGif(by id: String) -> Effect<GPHMedia,GiphySDKError>
}
