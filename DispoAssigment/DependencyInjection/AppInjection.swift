//
//  AppInjection.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/17/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { GiphyRepository() }.implements(GiphyService.self)
        register { MainViewModel() }
        register { MainViewController() }
        register { _, args in
          DetailViewModel(gifId: args())
        }
    }
}
