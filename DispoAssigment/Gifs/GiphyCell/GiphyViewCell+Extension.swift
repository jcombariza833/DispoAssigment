//
//  CellModel.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/6/22.
//

import Foundation
import UIKit

extension GiphyViewCell {
  struct GifItem: Hashable {
    var id: String
    var title: String
    var url: URL

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
      hasher.combine(title)
      hasher.combine(url.absoluteURL)
    }

    static func == (lhs: GifItem, rhs: GifItem) -> Bool {
      lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.url.absoluteURL == rhs.url.absoluteURL
    }
  }

  static func itemModel(item: GifItem,
                        didSelect: ((GiphyViewCell, GifItem) -> Void)? = nil) -> CollectionViewItem {
    CollectionViewItem(
      id: UUID(),
      item: item,
      reuseIdentifier: GiphyViewCell.reuseIdentifier,
      configure: { cell, item in
        cell.titleLabel.text = item.title
        cell.gifImage.load(url: item.url)
      },
      didSelect: didSelect

    )
  }
}
