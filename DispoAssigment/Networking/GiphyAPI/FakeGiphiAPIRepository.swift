//
//  FakeGiphiAPIRepository.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/28/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import ComposableArchitecture

class FakeGiphyAPIRepository: GiphyAPIService {
    
    var isFailing = true
    func fetchTrendingGifs() -> Effect<GroupResponse, NetworkError> {
        return Future<GroupResponse, NetworkError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(NetworkError.unableToRequest))
              } else {
                  promise(.success(GroupResponse.mockData))
              }
          }
        }.eraseToEffect()
    }
    
    func fetchGifs(by searchText: String) -> Effect<GroupResponse, NetworkError> {
        return Future<GroupResponse, NetworkError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(NetworkError.unableToRequest))
              } else {
                  promise(.success(GroupResponse.mockData))
              }
          }
        }.eraseToEffect()
    }
    
    func getGifDetail(by id: String) -> Effect<Response, NetworkError> {
        return Future<Response, NetworkError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(NetworkError.unableToRequest))
              } else {
                  promise(.success(Response.mockData))
              }
          }
        }.eraseToEffect()
    }
}
