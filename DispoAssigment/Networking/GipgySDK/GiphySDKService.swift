//
//  GiphySDKService.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/28/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import ComposableArchitecture

enum GiphySDKError: Error, Equatable {
    case errorFetchingMedia
}
protocol GiphySDKService {
    func getGif(by id: String) -> Effect<GPHMedia,GiphySDKError>
}

