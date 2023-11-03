//
//  NSObject+Extension.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: self)
    }
    
    public class var className: String {
        return String(describing: self)
    }
}
