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
    func getListOfPhotos(maxPhotos : Int, completion : @escaping (([UnplashImageInfo])->Void))
}

class UnplashNetworkManager {

}
