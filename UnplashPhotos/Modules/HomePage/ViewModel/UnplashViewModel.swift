//
//  UnplashViewModel.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import Foundation

class UnplashViewModel {
    
    init() {}
    
    func getListOfPhotos(completion : @escaping (_ imagesInfo : [UnplashImageInfo])->()) {
        let maxItems = GalleryConfg.maxItemsForPerPage()
        UnplashNetworkManager.shared.getListOfPhotos(maxPhotos: maxItems) { imagesInfo in
            completion(imagesInfo)
        }
    }
}
