//
//  DetailGifFeature.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/24/22.
//

import Foundation
import GiphyUISDK
import Alamofire
import ComposableArchitecture
import Resolver

struct DetailGifState: Equatable, Identifiable {
    var id = UUID()
    var gif: GIF
    var media: GPHMedia?
}

enum DetailGifAction: Equatable {
    case viewDidLoad
    case dataLoaded(Result<GPHMedia, GiphySDKError>)
}

struct DetailGifEnvironment {
    var giphySDK: GiphySDKService
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let detailGifReducer = Reducer<DetailGifState, DetailGifAction, DetailGifEnvironment> { state, action, environment in
    switch action {
    case .viewDidLoad:
        return environment.giphySDK.getGif(by: state.gif.id)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(DetailGifAction.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let response):
            state.media = response
        case .failure:
          break
        }
        return .none
    }
}
