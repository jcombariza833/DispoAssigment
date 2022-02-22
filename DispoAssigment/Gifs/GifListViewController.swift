//
//  MainViewController.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import UIKit
import SnapKit
import ComposableArchitecture
import Combine
import Resolver

class GifListViewController: ViewController<GiftsView> {
    
  var store: Store<GifListState, GifListAction>
  var viewStore: ViewStore<GifListState, GifListAction>
  var cancellables: Set<AnyCancellable> = []

  init(store: Store<GifListState, GifListAction>) {
    self.store = store
    self.viewStore = ViewStore(store)
    super.init()

    configureStateObservation()
    configureViewControllerObservation()
  }

  private func configureStateObservation() {
    viewStore.publisher.gifs
      .sink { [weak self] detailGifStates in
        var sections = [CollectionViewSection]()
        self?.configureSearchSection(sections: &sections)
        self?.configureGifListSection(sections: &sections, detailGifStates: detailGifStates.elements)
        self?.rootView.mainCollectionView.applySections(sections)
        self?.rootView.mainCollectionView.reloadData()
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
    view = GiftsView(layout: mainLayout)
  }
}

extension GifListViewController {
  enum Section: CaseIterable {
    case searchInput
    case gifList
  }

  enum CellType {
    case giftCell
    case searhCell
  }

  //MARK: - Section configuration
  func configureSearchSection(sections: inout [CollectionViewSection]) {
    sections.append(
      CollectionViewSection(
        id: Section.searchInput,
        items: [
          SearchViewCell.itemModel(
            id: CellType.searhCell,
            item: .init(text: self.viewStore.state.searchTerm),
            setBehaviors: { cell, item in
              cell.searchViewSubject
                .sink(receiveValue: { [weak self] action in
                  switch action {
                  case .searchTerm(let text):
                    self?.viewStore.send(.searchBarTextFieldChanged(text: text))
                  case .searchBarTextDidEndEditing:
                    self?.viewStore.send(.textDidEndEditing)
                  }
                })
                .store(in: &self.cancellables)
            }
          )
        ]
      )
    )
  }

  func configureGifListSection(sections: inout [CollectionViewSection], detailGifStates: [DetailGifState] ) {
    let states = detailGifStates
    if !detailGifStates.isEmpty {
      sections.append(
        CollectionViewSection(
          id: Section.gifList,
          items: states.enumerated().map { (index, state) in
            GiphyViewCell.itemModel(
              item: .init(
                id: state.gif.id,
                title: state.gif.title,
                url: state.gif.url
              ),
              didSelect: { cell, item in
                let vc = DetailViewController(
                  store: self.store.scope(
                    state: \.gifs[index],
                    action: { .detail(id: state.id, action: $0) }
                  )
                )
                self.navigationController?.pushViewController(vc, animated: false)
              }
            )
          }
        )
      )
    }
  }
  
  //MARK: - Layout
  var mainLayout: UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex , _ in
      let sectionLayoutKind = Section.allCases[sectionIndex]
      switch sectionLayoutKind {
      case .searchInput: return self?.searchInputLayout
      case .gifList: return self?.gifListLayout
      }
    }

    return layout
  }

  private var searchInputLayout: NSCollectionLayoutSection {
    let size = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(60)
    )
    let item = NSCollectionLayoutItem(
      layoutSize: size
    )

    let group = NSCollectionLayoutGroup.vertical(
        layoutSize: size,
        subitem: item,
        count: 1
    )
    group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging

    return section
  }

  private var gifListLayout: NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(60)
        )
    )

    let group = NSCollectionLayoutGroup.vertical(
        layoutSize:
          NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(64)
        ),
        subitem: item,
        count: 1
    )
    group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .none

    return section
  }
}
