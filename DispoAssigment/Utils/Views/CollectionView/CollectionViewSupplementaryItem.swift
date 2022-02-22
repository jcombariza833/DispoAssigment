//
//  CollectionViewSupplementaryItem.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/5/22.
//

import UIKit

// MARK: - CollectionViewSupplementaryItem

public struct CollectionViewSupplementaryItem {
  public let viewClass: UICollectionReusableView.Type
  public let item: AnyHashable
  public let reuseIdentifier: String
  public let configure: (UIView, Any) -> Void
  public let setBehaviors: (UIView, Any) -> Void
  public let willDisplay: (Any) -> Void

  public init<View: UICollectionReusableView, Item: Hashable>(
    item: AnyHashable,
    reuseIdentifier: String,
    configure: @escaping (View, Item) -> Void,
    setBehaviors: @escaping (View, Item) -> Void = { _, _ in },
    willDisplay: @escaping (Item) -> Void = { _ in }
  ) {
    viewClass = View.self
    self.item = item
    self.reuseIdentifier = reuseIdentifier

    self.configure = { view, item in
      configure(view as! View, item as! Item)
    }

    self.setBehaviors = { view, item in
      setBehaviors(view as! View, item as! Item)
    }

    self.willDisplay = { item in
      willDisplay(item as! Item)
    }
  }
}

// MARK: - CollectionViewSupplementaryItemKind

public enum CollectionViewSupplementaryItemKind: String, CaseIterable {
  case header, footer

  public var elementKind: String {
    rawValue
  }
}

extension CollectionViewSection {
  func supplementaryItem(kind: CollectionViewSupplementaryItemKind) -> CollectionViewSupplementaryItem? {
    switch kind {
    case .header: return header
    case .footer: return footer
    }
  }
}
