//
//  PhotoViewerViewController.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import UIKit

class PhotoViewerViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var image :  UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        displayImage()
        setupPinchGesture()
    }
    
    func setImage(_ image : UIImage?) {
        self.image = image
    }
    
    private func displayImage() {
        self.imageView.image = image
    }
    
    private func setupPinchGesture() {
       let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didZoom(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(pinchGesture)
     }

     @objc private func didZoom(_ sender: UIPinchGestureRecognizer) {
       let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
       guard let scale = scaleResult, scale.a > 1, scale.d > 1 else {
           return
       }
       sender.view?.transform = scale
       sender.scale = 1
     }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
