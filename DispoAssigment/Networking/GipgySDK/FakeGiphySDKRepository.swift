//
//  FakeGiphySDKRepository.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/28/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import ComposableArchitecture

struct FakeGiphySDKRepository: GiphySDKService {
    
    var isFailing = true
    
    func getGif(by id: String) -> Effect<GPHMedia, GiphySDKError> {
        return Future <GPHMedia, GiphySDKError> { promise in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                if self.isFailing {
                    promise(.failure(GiphySDKError.errorFetchingMedia))
                } else {
                    promise(.success(GPHMedia("fake id", type: .gif, url: "fake url")))
                }
            }
        }.eraseToEffect()
    }
}
