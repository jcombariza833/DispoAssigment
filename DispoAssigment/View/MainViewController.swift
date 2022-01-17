//
//  MainViewController.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import UIKit
import SnapKit
import Combine
import Resolver

class MainViewController: NiblessViewController {
    
    @Injected private var viewModel: MainViewModel
    
    private var subscriptions = Set<AnyCancellable>()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.rowHeight = 80.0
        tableView.register(GiphyTableViewCell.self,
                           forCellReuseIdentifier: GiphyTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        return searchBar
    }()

    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        setupUI()
        
        viewModel.$gifs
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }
    
    private func setupUI() {
        setupTableView()
        setupSearchBarView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalToSuperview()
        })
    }
    
    private func setupSearchBarView() {
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.titleView = searchBar
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        
        let viewController = viewModel.getDetailView(at: indexPath)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.gifs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.giftViewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GiphyTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? GiphyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: cellVM)
        
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTerm = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.loadData()
    }
}
