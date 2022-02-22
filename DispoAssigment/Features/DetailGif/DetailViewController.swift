//
//  DetailViewController.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import UIKit
import Combine
import SnapKit
import GiphyUISDK
import ComposableArchitecture

class DetailViewController: ViewController<DetailView> {
        
  var store: Store<DetailGifState, DetailGifAction>
  var viewStore: ViewStore<DetailGifState, DetailGifAction>
  var cancellables: Set<AnyCancellable> = []

  init(store: Store<DetailGifState, DetailGifAction>) {
    self.store = store
    self.viewStore = ViewStore(store)
    super.init()

    configureStateObservation()
    configureViewControllerObservation()
  }
    
  private func configureStateObservation() {
    viewStore.publisher.media
      .sink { [weak self] media in
        guard let media = media else { return }
        self?.rootView.titleContentLabel.text = media.title
        self?.rootView.sourceContentLabel.text = media.source
        self?.rootView.ratingContentLabel.text = self?.viewStore.gif.rating
        self?.rootView.gifView.media = media
      }
      .store(in: &cancellables)
  }

  private func configureViewControllerObservation() {
    viewDidAppearPublisher
      .sink { [weak self] _ in
        self?.viewStore.send(.viewDidLoad)
    }
    .store(in: &cancellables)
  }
    
  override func loadView() {
    view = DetailView()
  }
}

extension DetailViewController {
  enum Config {
      static let navigationTitle = "Gif Info Details"
  }
}
