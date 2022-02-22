//
//  GiphySDKRespository.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/28/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import ComposableArchitecture

struct GiphySDKRepository: GiphySDKService {
    
    func getGif(by id: String) -> Effect<GPHMedia, GiphySDKError> {
        return Future <GPHMedia, GiphySDKError> { promise in
            GiphyCore.shared.gifByID(id) { response, error in
                guard let media = response?.data else {
                    promise(.failure(GiphySDKError.errorFetchingMedia))
                    return
                }
                promise(.success(media))
            }
        }.eraseToEffect()
    }
}

