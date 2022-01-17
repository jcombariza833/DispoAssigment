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

class FakeGiphyRepository: GiphyService {
    var isFailing = true
    func fetchTrendingGifs() -> AnyPublisher<GroupResponse, AFError> {
        return Future<GroupResponse, AFError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(AFError.explicitlyCancelled))
              } else {
                  promise(.success(GroupResponse.mockData))
              }
          }
        }.eraseToAnyPublisher()
    }
    
    func fetchGifs(by searchText: String) -> AnyPublisher<GroupResponse, AFError> {
        return Future<GroupResponse, AFError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(AFError.explicitlyCancelled))
              } else {
                  promise(.success(GroupResponse.mockData))
              }
          }
        }.eraseToAnyPublisher()
    }
    
    func getGifInfo(by id: String) -> AnyPublisher<Response, AFError> {
        return Future<Response, AFError> { promise in
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              if self.isFailing {
                  promise(.failure(AFError.explicitlyCancelled))
              } else {
                  promise(.success(Response.mockData))
              }
          }
        }.eraseToAnyPublisher()
    }
    
    func getGif(by id: String) -> AnyPublisher<GPHMedia, GiphySDKError> {
        return Future <GPHMedia, GiphySDKError> { promise in
            GiphyCore.shared.gifByID(id) { response, error in
                if self.isFailing {
                    promise(.failure(GiphySDKError.errorFetchingMedia))
                } else {
                    promise(.success(GPHMedia("fake id", type: .gif, url: "fake url")))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
