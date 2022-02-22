//
//  CollectionViewSection.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/5/22.
//

import Foundation
import UIKit

// MARK: - CollectionViewSection

public struct CollectionViewSection: Hashable {
  public let id: AnyHashable
  public let items: [CollectionViewItem]
  public let header: CollectionViewSupplementaryItem?
  public let footer: CollectionViewSupplementaryItem?
  public let sectionProvider: () -> NSCollectionLayoutSection?

  public init(
    id: AnyHashable,
    items: [CollectionViewItem],
    header: CollectionViewSupplementaryItem? = nil,
    footer: CollectionViewSupplementaryItem? = nil,
    sectionProvider: @escaping () -> NSCollectionLayoutSection? = { nil }
  ) {
    self.id = id
    self.items = items
    self.header = header
    self.footer = footer
    self.sectionProvider = sectionProvider
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func == (lhs: CollectionViewSection, rhs: CollectionViewSection) -> Bool {
    lhs.id == rhs.id
  }
}

extension CollectionViewSection {
  public static func list(
    id: AnyHashable,
    items: [CollectionViewItem],
    estimatedHeight: CGFloat = 42
  ) -> CollectionViewSection {
    CollectionViewSection(
      id: id,
      items: items,
      sectionProvider: {
        let item = NSCollectionLayoutItem(
          layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(estimatedHeight)
          )
        )
        let group = NSCollectionLayoutGroup.vertical(
          layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(estimatedHeight)
          ),
          subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
      }
    )
  }
}
