//
//  DetailViewController.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import UIKit
import Combine
import SnapKit
import GiphyUISDK
import Resolver

class DetailViewController: NiblessViewController {
    
    private var viewModel: DetailViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.backgroundColor = .white
        
        return containerView
    }()
    
    private lazy var safeAreaView: UIView = {
        let safeAreaView = UIView(frame: .zero)
        safeAreaView.backgroundColor = .white
        
        return safeAreaView
    }()
    
    private lazy var gifView: GPHMediaView = {
        let gifView = GPHMediaView(frame: .zero)
        gifView.backgroundColor = .white
        
        return gifView
    }()
    
    private lazy var titleContainerView: UIStackView = {
        let titleContainerView = UIStackView(frame: .zero)
        titleContainerView.backgroundColor = .white
        titleContainerView.axis = .horizontal
        titleContainerView.distribution = .fillEqually
        titleContainerView.alignment = .leading
        
        return titleContainerView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var titleContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var sourceContainerView: UIStackView = {
        let sourceContainerView = UIStackView(frame: .zero)
        sourceContainerView.backgroundColor = .white
        sourceContainerView.axis = .horizontal
        sourceContainerView.distribution = .fillEqually
        sourceContainerView.alignment = .leading
        
        return sourceContainerView
    }()
    
    private var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var sourceContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var ratingContainerView: UIStackView = {
        let ratingContainerView = UIStackView(frame: .zero)
        ratingContainerView.backgroundColor = .white
        ratingContainerView.axis = .horizontal
        ratingContainerView.distribution = .fillEqually
        ratingContainerView.alignment = .leading
        
        return ratingContainerView
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var ratingContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchGif()
        setupUI()
        
        
        viewModel.$gifModel
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {  [unowned self] _ in
                self.titleLabel.text = self.viewModel.title
                self.titleContentLabel.text = self.viewModel.titleContent
                self.sourceLabel.text = self.viewModel.source
                self.sourceContentLabel.text = self.viewModel.sourceContent
                self.ratingLabel.text = self.viewModel.rating
                self.ratingContentLabel.text = self.viewModel.ratingContent
        }
        .store(in: &subscriptions)
        
        viewModel.$media
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {  [unowned self] media in
                self.gifView.media = media
        }
        .store(in: &subscriptions)
    }
    
    private func setupUI() {
        title = viewModel.navigationTitle
        setupContainerView()
        setupSafeView()
        setupGifView()
        setupTitleContainerView()
        setupSourceContainerView()
        setupRatingContainerView()
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalToSuperview()
        })
    }
    
    private func setupSafeView() {
        containerView.addSubview(safeAreaView)
        
        safeAreaView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
        })
    }
    
    private func setupGifView() {
        safeAreaView.addSubview(gifView)
       
        gifView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        })
    }
    
    private func setupTitleContainerView() {
        safeAreaView.addSubview(titleContainerView)
        titleContainerView.addArrangedSubview(titleLabel)
        titleContainerView.addArrangedSubview(titleContentLabel)
       
        titleContainerView.snp.makeConstraints({ (make) in
            make.top.equalTo(gifView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        })
    }
    
    private func setupSourceContainerView() {
        safeAreaView.addSubview(sourceContainerView)
        sourceContainerView.addArrangedSubview(sourceLabel)
        sourceContainerView.addArrangedSubview(sourceContentLabel)
       
        sourceContainerView.snp.makeConstraints({ (make) in
            make.top.equalTo(titleContainerView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        })
    }
    
    private func setupRatingContainerView() {
        safeAreaView.addSubview(ratingContainerView)
        ratingContainerView.addArrangedSubview(ratingLabel)
        ratingContainerView.addArrangedSubview(ratingContentLabel)
       
        ratingContainerView.snp.makeConstraints({ (make) in
            make.top.equalTo(sourceContainerView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        })
    }
}
