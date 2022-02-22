//
//  DetailView.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/21/22.
//

import UIKit
import Combine
import SnapKit
import GiphyUISDK

class DetailView: UIView {

  init() {
    super.init(frame: .zero)
    setupView()
  }

  private func setupView() {
      setupContainerView()
      setupSafeView()
      setupGifView()
      setupTitleContainerView()
      setupSourceContainerView()
      setupRatingContainerView()
  }

  //MARK: - Views

  private lazy var containerView: UIView = {
      let containerView = UIView(frame: .zero)
      containerView.backgroundColor = .white

      return containerView
  }()

  lazy var safeAreaView: UIView = {
      let safeAreaView = UIView(frame: .zero)
      safeAreaView.backgroundColor = .white

      return safeAreaView
  }()

  lazy var gifView: GPHMediaView = {
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
      label.text = Config.titleLabel

      return label
  }()

  private var sourceLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
      label.numberOfLines = 0
      label.text = Config.sourceLabel

      return label
  }()

  var titleContentLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
      label.numberOfLines = 0

      return label
  }()

  private var ratingLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
      label.numberOfLines = 0
      label.text = Config.ratingLabel

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

  var sourceContentLabel: UILabel = {
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



  var ratingContentLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
      label.numberOfLines = 0

      return label
  }()

  private func setupContainerView() {
      addSubview(containerView)

      containerView.snp.makeConstraints({ (make) in
          make.top.left.bottom.right.equalToSuperview()
      })
  }

  private func setupSafeView() {
      containerView.addSubview(safeAreaView)

      safeAreaView.snp.makeConstraints({ (make) in
        make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
          make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
          make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
          make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
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

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DetailView {
  enum Config {
      static let titleLabel = "Title:"
      static let sourceLabel = "Source:"
      static let ratingLabel = "Rating:"
  }
}
