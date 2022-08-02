//
//  AlbumDetailPageViewController.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import UIKit

final class AlbumDetailPageViewController: UIViewController {
    
    @IBOutlet weak var albumNameLabelOutlet: UILabel!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    private let callPhotosAPI = KAPhotosAPI()
    private var photosData: [KAPhotosResponseModel] = []
    var albumID: Int = 0
    var albumName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumNameLabelOutlet.text = "Albun Name: \(albumName)"
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        callPhotosAPI.getPhotosKA(id: albumID) { result in
            switch result {
            case let .success(data):
                self.photosData.append(contentsOf: data)
                self.collectionViewOutlet.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
    }
}

extension AlbumDetailPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumDetailCollectionCell", for: indexPath) as! AlbumDetailCollectionCell
        let photosDataCell = photosData[indexPath.row]
        reuseCollectionCell.layer.borderColor = UIColor.systemGray3.cgColor
        reuseCollectionCell.layer.borderWidth = 1
        reuseCollectionCell.layer.cornerRadius = 8
        reuseCollectionCell.photosImageOutlet.setImageFrom(photosDataCell.thumbnailURL!)
        reuseCollectionCell.photosNameLabelOutlet.text = photosDataCell.title
        return reuseCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailPageViewController = UIStoryboard(name: "PhotoDetailPageViewController", bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailPageViewController") as! PhotoDetailPageViewController
        let photosDataCell = photosData[indexPath.row]
        photoDetailPageViewController.photoName = photosDataCell.title ?? ""
        photoDetailPageViewController.photoOriginalURL = photosDataCell.url ?? ""
        self.navigationController?.pushViewController(photoDetailPageViewController, animated: true)
    }
}

extension AlbumDetailPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 149, height: 182)
    }
}
