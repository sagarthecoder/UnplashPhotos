//
//  ImageURLs.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import UIKit

struct ImageURLs : Codable {
    var regular : String?
    var small : String?
    var thumb : String?
    var full : String?
    
    enum CodingKeys : String, CodingKey {
        case regular  = "regular"
        case small = "small"
        case thumb  = "thumg"
        case full = "full"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.regular = try container.decodeIfPresent(String.self, forKey: .regular)
        self.small = try container.decodeIfPresent(String.self, forKey: .small)
        self.thumb = try container.decodeIfPresent(String.self, forKey: .thumb)
        self.full = try container.decodeIfPresent(String.self, forKey: .full)
    }
}
