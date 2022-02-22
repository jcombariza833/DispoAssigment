//
//  GiftsView.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/4/22.
//

import UIKit
import SnapKit

class GiftsView: UIView {

  init(layout: UICollectionViewLayout) {
    mainCollectionView = CollectionView(layout: layout)
    super.init(frame: .zero)
    setupView()
  }

  private func setupView() {
    addSubview(container)
    container.addSubview(mainCollectionView)

    mainCollectionView.backgroundColor = .clear
    mainCollectionView.alwaysBounceVertical = true
    mainCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
    mainCollectionView.keyboardDismissMode = .onDrag
    mainCollectionView.showsVerticalScrollIndicator = false
    mainCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    container.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }

    mainCollectionView.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
      $0.leading.trailing.equalToSuperview()
    }
  }

  //MARK: - Views
  lazy var container: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = .white

    return view
  }()

  var mainCollectionView: CollectionView

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
