//
//  HomePageViewController.swift
//  UnplashPhotos
//
//  Created by Sagar on 11/3/23.
//

import UIKit

class HomePageViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var unplashViewModel : UnplashViewModel?
    let identifier = PhotoCollectionViewCell.className
    var items = [UnplashImageInfo]()
    var pageNo = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updatePhotosFromAPi()
    }
    
    private func setupViews() {
        setViewModel()
        setupCollectionView()
        registerNibs()
    }
    
    private func setViewModel() {
        unplashViewModel = UnplashViewModel()
    }
    
    private func setupCollectionView(){
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 3.0
        layout.minimumInteritemSpacing = 2.0
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout
        collectionView.isPrefetchingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
    }
    
    private func registerNibs() {
        let nib = UINib(nibName: PhotoCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        collectionView.reloadData()
    }
    
    private func updatePhotosFromAPi() {
        let maxPhotos = GalleryConfg.maxItemsForPerPage()
        unplashViewModel?.getListOfPhotos(pageNo: pageNo, maxPhotos: maxPhotos, completion: { imagesInfo in
            DispatchQueue.main.async {
                self.items += imagesInfo
                self.collectionView.reloadData()
            }
        })
    }
}

extension HomePageViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}

extension HomePageViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        if indexPath.item < items.count {
            let item = items[indexPath.item]
            if let imageURLString = item.urls?.small, let url = URL(string: imageURLString) {
                cell.imageView.kf.setImage(with: url)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < items.count {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else {
                return
            }
            let image = cell.imageView.image
            gotoPhotoViewerPage(image: image)
            
        }
    }
    
    private func gotoPhotoViewerPage(image : UIImage?) {
        guard let image = image else {
            return
        }
        let photoViewerVC = PhotoViewerViewController()
        photoViewerVC.setImage(image)
        self.navigationController?.pushViewController(photoViewerVC, animated: true)
        
    }
}

extension HomePageViewController : CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = CGSize(width: 400.0, height: 400.0)
        if indexPath.item < items.count {
            let item = items[indexPath.item]
            if let width = item.width, let height = item.height {
                let aspectSize = CalculationManager.aspectFit(aspectRatio: CGSize(width: CGFloat(width), height: CGFloat(height)), boundingSize: maxSize)
                return aspectSize
            } else {
                return maxSize
            }
        } else {
            return maxSize
        }
    }
    
}

extension HomePageViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let lastIndex = items.count - 1
        if lastIndex >= 0  {
            let lastIndexPath = IndexPath(item: lastIndex, section: 0)
            if indexPaths.contains(lastIndexPath) {
                pageNo += 1
                updatePhotosFromAPi()
            }
        }
    }
    
    
}
