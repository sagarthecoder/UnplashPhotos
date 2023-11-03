//
//  UnplashImageInfo.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import UIKit

struct UnplashImageInfo : Codable {
    var urls : ImageURLs?
    var width : Int?
    var height : Int?
    
    enum CodingKeys : String, CodingKey {
        case urls = "urls"
        case width = "width"
        case height = " height"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.urls = try container.decodeIfPresent(ImageURLs.self, forKey: .urls)
        self.width = try container.decodeIfPresent(Int.self, forKey: .width)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
    }
}
