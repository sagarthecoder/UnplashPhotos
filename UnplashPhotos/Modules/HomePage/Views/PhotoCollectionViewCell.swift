//
//  PhotoCollectionViewCell.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.kf.indicatorType = .activity
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }

}
