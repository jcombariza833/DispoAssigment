//
//  GiphyTableViewModelCell.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/16/22.
//

import Foundation

final class GiphyViewModelCell {
    private let gif: GIF
    
    var title: String {
        gif.title
    }
    
    var url: URL {
        gif.url
    }
    
    init(gif: GIF) {
        self.gif = gif
    }
}
