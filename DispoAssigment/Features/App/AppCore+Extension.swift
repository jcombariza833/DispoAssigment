//
//  AppCore+Extension.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 2/19/22.
//

import Foundation
import GiphyUISDK
import Resolver
import ComposableArchitecture
import UIKit
import SwiftUI

extension AppEnvironment {
  static func live() -> Self {
    Self(giphyAPI: GiphyAPIRepository(),
         giphySDK: GiphySDKRepository(),
         mainQueue: { .main }
    )
  }

  static func dev() -> Self {
    Self(giphyAPI: FakeGiphyAPIRepository(),
         giphySDK: FakeGiphySDKRepository(),
         mainQueue: { .main }
    )
  }
}
