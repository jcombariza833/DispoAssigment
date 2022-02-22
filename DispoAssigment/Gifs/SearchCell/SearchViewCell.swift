//
//  SearchViewCell.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/7/22.
//

import UIKit
import SnapKit
import Combine

class SearchViewCell: UICollectionViewCell {

  static let reuseIdentifier = "SearchViewCell"
  let searchViewSubject = PassthroughSubject<Action, Never>()

  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.sizeToFit()
    searchBar.placeholder = "Search here"

    return searchBar
  }()


  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  private func setupUI(){
    addSubview(searchBar)

    searchBar.snp.makeConstraints { make in
      make.height.equalTo(50)
      make.leading.trailing.equalToSuperview()
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    prepareForConfiguration()
  }

  private func prepareForConfiguration() {
    searchBar.text = nil
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SearchViewCell: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      self.searchViewSubject.send(.searchTerm(searchText))
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      self.searchViewSubject.send(.searchBarTextDidEndEditing)
    }
}

extension SearchViewCell {
  enum Action {
    case searchTerm(String)
    case searchBarTextDidEndEditing
  }
}
