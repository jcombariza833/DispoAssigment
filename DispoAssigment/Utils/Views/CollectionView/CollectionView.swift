//
//  CollectionView.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/5/22.
//
import UIKit

// MARK: - CollectionView

open class CollectionView: UICollectionView {
  private lazy var collectionViewDataSource = CollectionViewDataSource(collectionView: self)

  /// A delegate for handling `UIScrollViewDelegate` callbacks related to scrolling.
  ///
  /// Zooming delegate methods are ignored.
  public weak var scrollDelegate: UIScrollViewDelegate?

  public init(
    layout: UICollectionViewLayout
  ) {
    super.init(frame: .zero, collectionViewLayout: layout)
    backgroundColor = .clear
    setUp()
  }

  public func applySections(
    _ sections: [CollectionViewSection],
    animated: Bool = true
  ) {
    collectionViewDataSource.registerSections(sections)
    let snapshot = sections.snapshot
    configureUpdatedCells(
      snapshot: snapshot,
      previousSnapshot: collectionViewDataSource.snapshot()
    )
    collectionViewDataSource.apply(snapshot, animatingDifferences: animated)
    resetBehaviors()
  }

  private func configureUpdatedCells(
    snapshot: CollectionViewDataSource.Snapshot,
    previousSnapshot: CollectionViewDataSource.Snapshot
  ) {
    let previousItemsTuple = previousSnapshot.itemIdentifiers.map { ($0.id, $0) }
    let previousItemDict = Dictionary(uniqueKeysWithValues: previousItemsTuple)

    for item in snapshot.itemIdentifiers {
      if
        let indexPath = collectionViewDataSource.indexPath(for: item),
        let cell = cellForItem(at: indexPath),
        let previousItem = previousItemDict[item.id],
        item.item != previousItem.item
      {
        item.configure(cell, item.item)
      }
    }

    for (sectionIndex, section) in snapshot.sectionIdentifiers.enumerated() {
      if
        let previousSection = previousSnapshot.sectionIdentifiers
        .first(where: { $0.id == section.id })
      {
        if
          let header = section.header,
          previousSection.header?.item != header.item,
          let view = supplementaryView(
            forElementKind: CollectionViewSupplementaryItemKind.header.elementKind,
            at: IndexPath(item: 0, section: sectionIndex)
          )
        {
          header.configure(view, header.item)
        }
        if
          let footer = section.footer,
          previousSection.footer?.item != footer.item,
          let view = supplementaryView(
            forElementKind: CollectionViewSupplementaryItemKind.footer.elementKind,
            at: IndexPath(item: 0, section: sectionIndex)
          )
        {
          footer.configure(view, footer.item)
        }
      }
    }
  }

  public var sections: [CollectionViewSection] {
    collectionViewDataSource.snapshot().sectionIdentifiers
  }

  private func setUp() {
    dataSource = collectionViewDataSource
    delegate = self
  }

  private func resetBehaviors() {
    for indexPath in indexPathsForVisibleItems {
      guard let cell = cellForItem(at: indexPath) else {
        return
      }
      if let item = collectionViewDataSource.itemIdentifier(for: indexPath) {
        item.setBehaviors?(cell, item.item)
      }
    }

    let sections = self.sections
    for kind in CollectionViewSupplementaryItemKind.allCases {
      for indexPath in indexPathsForVisibleSupplementaryElements(ofKind: kind.rawValue) {
        let section = sections[indexPath.section]
        guard
          let view = supplementaryView(forElementKind: kind.rawValue, at: indexPath),
          let item = section.supplementaryItem(kind: kind)
        else {
          return
        }
        item.setBehaviors(view, item.item)
      }
    }
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: UICollectionViewDelegate

extension CollectionView: UICollectionViewDelegate {
  public func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    if let item = collectionViewDataSource.itemIdentifier(for: indexPath) {
      item.willDisplay?(item.item)
    }
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    didEndDisplaying cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    if let item = collectionViewDataSource.itemIdentifier(for: indexPath) {
      item.didEndDisplaying?(item.item)
    }
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    if
      let cell = collectionView.cellForItem(at: indexPath),
      let item = collectionViewDataSource.itemIdentifier(for: indexPath)
    {
      item.didSelect?(cell, item.item)
    }
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    willDisplaySupplementaryView view: UICollectionReusableView,
    forElementKind elementKind: String,
    at indexPath: IndexPath
  ) {
    let sections = collectionViewDataSource.snapshot().sectionIdentifiers
    if
      let kind = CollectionViewSupplementaryItemKind(rawValue: elementKind),
      let item = sections[indexPath.section].supplementaryItem(kind: kind)
    {
      item.willDisplay(item.item)
    }
  }
}

// MARK: UIScrollViewDelegate

extension CollectionView: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollDelegate?.scrollViewDidScroll?(scrollView)
  }

  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
  }

  public func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    scrollDelegate?.scrollViewWillEndDragging?(
      scrollView,
      withVelocity: velocity,
      targetContentOffset: targetContentOffset
    )
  }

  public func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool
  ) {
    scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }

  public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
    scrollDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
  }

  public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    scrollDelegate?.scrollViewDidScrollToTop?(scrollView)
  }

  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    scrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
  }

  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
  }

  public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    scrollDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
  }
}

extension CollectionView {
  public static func createLayout(
    sectionProvider: @escaping () -> [CollectionViewSection]?
  ) -> UICollectionViewLayout {
    UICollectionViewCompositionalLayout.init { section, _ in
      guard
        let sections = sectionProvider(),
        sections.indices.contains(section)
      else { return nil }
      return sections[section].sectionProvider()
    }
  }

  public static func createHorizontalLayout(
    sectionProvider: @escaping () -> [CollectionViewSection]?,
    interSectionSpacing: CGFloat = 0
  ) -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout.init { section, _ in
      guard
        let sections = sectionProvider(),
        sections.indices.contains(section)
      else { return nil }
      return sections[section].sectionProvider()
    }
    let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
    layoutConfig.scrollDirection = .horizontal
    layoutConfig.interSectionSpacing = interSectionSpacing
    layout.configuration = layoutConfig
    return layout
  }
}
