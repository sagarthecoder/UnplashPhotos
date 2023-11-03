//
//  UnplashAPI.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import Foundation
import Moya

////https://api.unsplash.com/photos/?client_id=LSTTedZFb3sy1uTRg5_mjQZLR01wf7AwEYBkrRcPf6c&order_by=ORDER&per_page=2
///
enum UnplashAPI {
    case getListOfPhotos(maxPhotos : Int)
}

extension UnplashAPI : TargetType {
    var baseURL: URL {
            return URL(string: "https://api.unsplash.com")!
        }
    
    
    var path: String {
        switch self {
        case .getListOfPhotos(_):
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        let apiKey = UnplashConfig.getAccessKey()
        switch self {
        case .getListOfPhotos(let maxPhotos):
            return .requestParameters(parameters: ["client_id" : apiKey, "order_by" : "ORDER", "per_page" : maxPhotos], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
