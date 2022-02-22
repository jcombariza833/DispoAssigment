//
//  FakeGiphyRepository.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/16/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import ComposableArchitecture

class FakeGiphyRepository: GiphyService {
    
    var isFailing = true
    func fetchTrendingGifs() -> Effect<GroupResponse, AFError> {
        return Future<GroupResponse, AFError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(AFError.explicitlyCancelled))
              } else {
                  promise(.success(GroupResponse.mockData))
              }
          }
        }.eraseToEffect()
    }
    
    func fetchGifs(by searchText: String) -> Effect<GroupResponse, AFError> {
        return Future<GroupResponse, AFError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(AFError.explicitlyCancelled))
              } else {
                  promise(.success(GroupResponse.mockData))
              }
          }
        }.eraseToEffect()
    }
    
    func getGifInfo(by id: String) -> Effect<Response, AFError> {
        return Future<Response, AFError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(AFError.explicitlyCancelled))
              } else {
                  promise(.success(Response.mockData))
              }
          }
        }.eraseToEffect()
    }
    
    func getGif(by id: String) -> Effect<GPHMedia, GiphySDKError> {
        return Future <GPHMedia, GiphySDKError> { promise in
            GiphyCore.shared.gifByID(id) { response, error in
                if self.isFailing {
                    promise(.failure(GiphySDKError.errorFetchingMedia))
                } else {
                    promise(.success(GPHMedia("fake id", type: .gif, url: "fake url")))
                }
            }
        }.eraseToEffect()
    }
    
}
