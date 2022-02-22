//
//  Data.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import Foundation
import SwiftUI
import GiphyUISDK

struct GroupResponse: Codable, Equatable {
    var data: [GIF]
}

struct Response: Codable, Equatable {
    var data: GIF
}

struct GIF: Equatable, Identifiable {
    var id: String
    var title: String
    var source: String
    var rating: String
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case source = "source_tld"
        case rating
        case images
        case media
    }
    
    enum ImagesCodingKeys: String, CodingKey {
        case original
    }
    
    enum OriginalCodingKeys: String, CodingKey {
        case url
    }
}

extension GIF: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        source = try values.decode(String.self, forKey: .source)
        rating = try values.decode(String.self, forKey: .rating)
        
        let images = try values.nestedContainer(keyedBy: ImagesCodingKeys.self, forKey: .images)
        let original = try images.nestedContainer(keyedBy: OriginalCodingKeys.self, forKey: .original)
        url = try original.decode(URL.self, forKey: .url)
    }
}

extension GIF: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(source, forKey: .source)
        try container.encode(rating, forKey: .rating)
        
        var images = container.nestedContainer(keyedBy: ImagesCodingKeys.self, forKey: .images)
        var original = images.nestedContainer(keyedBy: OriginalCodingKeys.self, forKey: .original)
        try original.encode(url, forKey: .url)
    }
}

extension GIF {
    static let mockData = GIF(id: "Fake id",
                              title: "Fake title",
                              source: "Fake source",
                              rating: "Fake raiting",
                              url: URL(string: "www.google.com")!)
}

extension Response {
    static let mockData = Response(data: GIF.mockData)
}

extension GroupResponse {
    static let mockData = GroupResponse(data: [GIF.mockData])
}
