//
//  GifsFeature.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/24/22.
//

import Foundation
import Alamofire
import Resolver
import ComposableArchitecture

struct GifListState: Equatable {
  var gifs: IdentifiedArrayOf<DetailGifState> = []
  var searchTerm: String = ""
}

enum GifListAction: Equatable {
    case viewDidLoad
    case searchBarTextFieldChanged(text: String)
    case detail(id: DetailGifState.ID, action: DetailGifAction)
    case textDidEndEditing
    case dataLoaded(Result<GroupResponse, NetworkError>)
}

struct GifListEnviroment {
    var giphyAPI: GiphyAPIService
    var giphySDK: GiphySDKService
    var mainQueue: AnySchedulerOf<DispatchQueue>
}


let gifListReducer = Reducer<GifListState, GifListAction, GifListEnviroment>.combine(
    detailGifReducer.forEach(state: \.gifs,
                             action: /GifListAction.detail(id:action:),
                             environment: { environment in
                                 DetailGifEnvironment(
                                    giphySDK: environment.giphySDK,
                                    mainQueue: environment.mainQueue
                                 )
                                    
                             }
    ),
    Reducer { state, action, environment in
        switch action {
        case .viewDidLoad, .textDidEndEditing:
            if state.searchTerm.isEmpty {
                return environment.giphyAPI.fetchTrendingGifs()
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(GifListAction.dataLoaded)
            } else {
                return environment.giphyAPI.fetchGifs(by: state.searchTerm)
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(GifListAction.dataLoaded)
            }
        case .searchBarTextFieldChanged(text: let text):
          state.searchTerm = text
          if text.isEmpty {
            return Effect(value:. textDidEndEditing)
          }
            return .none
        case .dataLoaded(let result):
            switch result {
            case .success(let response):
                let gifs = response.data
                let gifItems = IdentifiedArrayOf<DetailGifState>(
                    uniqueElements: gifs.map {
                        DetailGifState(gif: $0)
                    }
                )
                state.gifs = gifItems
            case .failure:
              break
            }
            return .none
        case .detail:
            return .none
        }
    }
)
