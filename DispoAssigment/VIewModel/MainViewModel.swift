//
//  MainViewModel.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import Foundation
import Combine
import Alamofire
import Resolver

final class MainViewModel: ObservableObject {
    @Published var gifs: [GIF] = []
    @Published var searchTerm: String = ""
    
    @Injected private var repository: GiphyService
    
    var giftViewModels: [GiphyViewModelCell] {
        gifs.map { GiphyViewModelCell(gif: $0) }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    func loadData() {
        if searchTerm.isEmpty {
            fetchTrending()
        } else {
            fetchSearching()
        }
    }
    
    func getDetailView(at indexPath: IndexPath) -> DetailViewController {
        let id = gifs[indexPath.row].id
        
        return DetailViewController(viewModel: Resolver.resolve(args: id))
    }
    
    private func fetchTrending() {
        repository.fetchTrendingGifs()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(_): self.gifs = []
                }
            }, receiveValue: { response in
                self.gifs = response.data
            })
            .store(in: &subscriptions)
    }
    
    private func fetchSearching() {
        repository.fetchGifs(by: searchTerm)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(_): self.gifs = []
                }
            }, receiveValue: { response in
                self.gifs = response.data
            })
            .store(in: &subscriptions)
    }
}
