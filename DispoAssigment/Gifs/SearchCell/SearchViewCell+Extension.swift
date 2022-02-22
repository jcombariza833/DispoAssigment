//
//  Item.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/7/22.
//

import Foundation
import UIKit

extension SearchViewCell {
  struct SearchItem: Hashable {
    var id = UUID()
    var text: String

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
      hasher.combine(text)
    }

    static func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
      lhs.id == rhs.id
        && lhs.text == rhs.text
    }
  }

  static func itemModel(id: AnyHashable,
                        item: SearchItem,
                        setBehaviors: ((SearchViewCell, SearchItem) -> Void)? = nil,
                        didSelect: ((SearchViewCell, SearchItem) -> Void)? = nil) -> CollectionViewItem {
    CollectionViewItem(
      id: id,
      item: item,
      reuseIdentifier: SearchViewCell.reuseIdentifier,
      configure: { cell, item in
        cell.searchBar.text = item.text
      },
      setBehaviors: setBehaviors,
      didSelect: didSelect
    )
  }
}
