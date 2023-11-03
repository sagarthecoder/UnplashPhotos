//
//  UnplashNetworkManager.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import Foundation
import Moya

protocol Networkable : AnyObject {
    var provider : MoyaProvider<UnplashAPI> { get }
    func getListOfPhotos(maxPhotos : Int, pageNo : Int, completion : @escaping (([UnplashImageInfo])->Void))
}

class UnplashNetworkManager : Networkable {
    private init() {}
    
    static let shared = UnplashNetworkManager()
    var provider = MoyaProvider<UnplashAPI>()
    
    func getListOfPhotos(maxPhotos: Int, pageNo : Int, completion: @escaping (([UnplashImageInfo]) ->())) {
        provider.request(.getListOfPhotos(maxPhotos: maxPhotos, pageNo: pageNo)) { result in
            switch result {
            case .success(let response):
                do {
                    let imageInfos = try JSONDecoder().decode([UnplashImageInfo].self, from: response.data)
                    completion(imageInfos)
                } catch let error {
                    print("Unplash API fetching Error = \(error.localizedDescription)")
                }
                break
            case .failure(let error):
                print("Unplash API fetching Error = \(error.localizedDescription)")
                break
            }
        }
    }
    
}
