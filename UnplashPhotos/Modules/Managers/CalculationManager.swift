//
//  CalculationManager.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import Foundation

final class CalculationManager {
    private init() {}
    
    class func aspectFit(aspectRatio : CGSize, boundingSize: CGSize) -> CGSize {
        var aspectSize  = boundingSize
        let mW = boundingSize.width / aspectRatio.width;
        let mH = boundingSize.height / aspectRatio.height;
        
        if( mH < mW ) {
            aspectSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW < mH ) {
            aspectSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
        }
        return aspectSize;
    }
    
}
