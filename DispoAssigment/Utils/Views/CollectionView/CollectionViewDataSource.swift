//
//  CollectionViewDataSource.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/5/22.
//

import UIKit

public class CollectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem> {
  public typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>
  weak var collectionView: CollectionView?

  init(collectionView: CollectionView) {
    self.collectionView = collectionView

    super.init(collectionView: collectionView) {
      collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: item.reuseIdentifier,
        for: indexPath
      )
      item.configure(cell, item.item)
      item.setBehaviors?(cell, item.item)
      return cell
    }

    supplementaryViewProvider = { collectionView, elementKind, indexPath in
      let collectionView = collectionView as! CollectionView
      let section = collectionView.sections[indexPath.section]

      guard
        let kind = CollectionViewSupplementaryItemKind(rawValue: elementKind),
        let item = section.supplementaryItem(kind: kind)
      else {
        return nil
      }

      let view = collectionView.dequeueReusableSupplementaryView(
        ofKind: elementKind,
        withReuseIdentifier: item.reuseIdentifier,
        for: indexPath
      )
      item.configure(view, item.item)
      item.setBehaviors(view, item.item)
      return view
    }
  }

  func registerSections(_ sections: [CollectionViewSection]) {
    for section in sections {
      for item in section.items {
        collectionView?.register(
          item.cellClass,
          forCellWithReuseIdentifier: item.reuseIdentifier
        )
      }

      for kind in CollectionViewSupplementaryItemKind.allCases {
        guard let item = section.supplementaryItem(kind: kind) else {
          continue
        }
        collectionView?.register(
          item.viewClass,
          forSupplementaryViewOfKind: kind.rawValue,
          withReuseIdentifier: item.reuseIdentifier
        )
      }
    }
  }
}
