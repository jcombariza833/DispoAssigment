//
//  DetailViewModel.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import Foundation
import Combine
import Alamofire
import GiphyUISDK
import Resolver

final class DetailViewModel: ObservableObject {
    @Published var gifModel: GIF? = nil
    @Published var media: GPHMedia? = nil
    
    var gifId: String
    @Injected private var repository: GiphyService
    
    
    var identifier: String {
        gifId
    }
    
    var title: String {
        "Title:"
    }
    var titleContent: String {
        gifModel?.title ?? ""
    }
    
    var source: String {
        "Source:"
    }
    
    var sourceContent: String {
        gifModel?.source ?? ""
    }
    
    var rating: String {
        "Rating:"
    }
    
    var ratingContent: String {
        gifModel?.rating ?? ""
    }
    
    var navigationTitle: String {
        "Gif Info Details"
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(gifId: String) {
        self.gifId = gifId
    }
    
    func fetchGif() {
        repository.getGifInfo(by: gifId)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.gifModel = nil
                }
            }, receiveValue: { response in
                self.gifModel = response.data
            })
            .store(in: &subscriptions)
        
        repository.getGif(by: gifId)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.media = nil
                }
            }, receiveValue: { media in
                self.media = media
            })
            .store(in: &subscriptions)
    }
}
