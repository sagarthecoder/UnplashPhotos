//
//  UnplashViewModel.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import Foundation

class UnplashViewModel {
    
    init() {}
    
    func getListOfPhotos(pageNo : Int, maxPhotos : Int, completion : @escaping (_ imagesInfo : [UnplashImageInfo])->()) {
        UnplashNetworkManager.shared.getListOfPhotos(maxPhotos: maxPhotos, pageNo: pageNo) { imagesInfo in
            completion(imagesInfo)
        }
    }
}
