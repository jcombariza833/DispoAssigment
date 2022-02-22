//
//  AppViewController.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/19/22.
//

import UIKit
import ComposableArchitecture
import Combine
import SnapKit

class AppViewController: ViewController<UIView> {
  var store: Store<AppState, AppAction>
  var viewStore: ViewStore<AppState, AppAction>
  var cancellables: Set<AnyCancellable> = []

  init(store: Store<AppState, AppAction>) {
    self.store = store
    self.viewStore = ViewStore(store)
    super.init()

    configureStateObservation()
    configureViewControllerObservation()
  }

  private func configureStateObservation() {
    viewStore.publisher.loggenIn
      .dropFirst()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] loggedIn in
        guard let self = self else { return }
        if loggedIn {
          let vc = GifListViewController(
            store: self.store.scope(
              state: \.gifListState,
              action: AppAction.presentGifList
            )
          )

          let navigation = UINavigationController(rootViewController: vc)
          navigation.modalPresentationStyle = .fullScreen
          self.present(navigation, animated: false)
        } else {
          print("present onBoarding")
        }

      })
      .store(in: &cancellables)
  }

  private func configureViewControllerObservation() {
    viewDidAppearPublisher
      .sink { [weak self] _ in
        self?.viewStore.send(.onAppear)
      }
      .store(in: &cancellables)
  }

  private lazy var mainView: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = .white
    return view
  }()

  public override func loadView() {
    view = mainView
  }
}

