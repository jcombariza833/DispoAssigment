//
//  Array+Extension.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/5/22.
//

import Foundation
import UIKit

extension Array where Element == CollectionViewSection {
  var snapshot: NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem> {
    var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
    forEach { section in
      snapshot.appendSections([section])
      snapshot.appendItems(section.items)
    }
    return snapshot
  }
}
