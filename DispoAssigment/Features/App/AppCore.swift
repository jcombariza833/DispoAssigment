//
//  RootFeature.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/24/22.
//

import Foundation
import GiphyUISDK
import Resolver
import ComposableArchitecture
import UIKit
import SwiftUI

struct AppState: Equatable {
  var loggenIn = false
  var gifListState = GifListState()
}

enum AppAction: Equatable {
  case onAppear
  case presentGifList(GifListAction)
}

struct AppEnvironment {
    var giphyAPI: GiphyAPIService
    var giphySDK: GiphySDKService
    var mainQueue: () -> AnySchedulerOf<DispatchQueue>
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    gifListReducer.pullback(
        state: \.gifListState,
        action: /AppAction.presentGifList,
        environment: { environment in
            GifListEnviroment(giphyAPI: environment.giphyAPI,
                              giphySDK: environment.giphySDK,
                              mainQueue: environment.mainQueue())
        }
    ),
    Reducer { state, action, environment in
        switch action {
        case .onAppear:
          state.loggenIn = true
          return .none
        case .presentGifList:
          return .none
        }
    }
)
