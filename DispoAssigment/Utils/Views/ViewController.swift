//
//  ViewController.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/4/22.
//

import Foundation
import Combine
import UIKit

class ViewController<View: UIView>: UIViewController {
  public var rootView: View {
    view as! View
  }

  public var viewWillAppearPublisher: AnyPublisher<Void, Never> {
    viewWillAppearSubject.eraseToAnyPublisher()
  }

  public var viewDidAppearPublisher: AnyPublisher<Void, Never> {
    viewDidAppearSubject.eraseToAnyPublisher()
  }

  public var viewWillDisappearPublisher: AnyPublisher<Void, Never> {
    viewWillDisappearSubject.eraseToAnyPublisher()
  }

  public var viewDidDisappearPublisher: AnyPublisher<Void, Never> {
    viewDidDisappearSubject.eraseToAnyPublisher()
  }

  private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
  private let viewDidAppearSubject = PassthroughSubject<Void, Never>()
  private let viewWillDisappearSubject = PassthroughSubject<Void, Never>()
  private let viewDidDisappearSubject = PassthroughSubject<Void, Never>()

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewWillAppearSubject.send()
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewDidAppearSubject.send()
  }

  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewWillDisappearSubject.send()
  }

  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewDidDisappearSubject.send()
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
