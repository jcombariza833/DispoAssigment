//
//  CollectionViewItem.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/5/22.
//

import Foundation
import UIKit
import Combine

public struct CollectionViewItem: Hashable {
  public let cellClass: UICollectionViewCell.Type
  public let id: AnyHashable
  public let item: AnyHashable
  public let reuseIdentifier: String
  public let configure: (UICollectionViewCell, Any) -> Void
  public let setBehaviors: ((UICollectionViewCell, Any) -> Void)?
  public let didSelect: ((UICollectionViewCell, Any) -> Void)?
  public let willDisplay: ((Any) -> Void)?
  public let didEndDisplaying: ((Any) -> Void)?

  public init<Cell: UICollectionViewCell, Item: Hashable>(
    id: AnyHashable,
    item: Item,
    reuseIdentifier: String,
    configure: @escaping (Cell, Item) -> Void,
    setBehaviors: ((Cell, Item) -> Void)? = nil,
    didSelect: ((Cell, Item) -> Void)? = nil,
    willDisplay: ((Item) -> Void)? = nil,
    didEndDisplaying: ((Item) -> Void)? = nil
  ) {
    cellClass = Cell.self
    self.id = id
    self.item = item
    self.reuseIdentifier = reuseIdentifier

    self.configure = { cell, item in
      configure(cell as! Cell, item as! Item)
    }

    self.setBehaviors = setBehaviors.map { setBehaviors in
      { cell, item in
        setBehaviors(cell as! Cell, item as! Item)
      }
    }

    self.didSelect = didSelect.map { didSelect in
      { cell, item in
        didSelect(cell as! Cell, item as! Item)
      }
    }

    self.willDisplay = willDisplay.map { willDisplay in
      { item in
        DispatchQueue.main.async {
          willDisplay(item as! Item)
        }
      }
    }

    self.didEndDisplaying = didEndDisplaying.map { didEndDisplaying in
      { item in
        didEndDisplaying(item as! Item)
      }
    }
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func == (lhs: CollectionViewItem, rhs: CollectionViewItem) -> Bool {
    lhs.id == rhs.id
  }
}
