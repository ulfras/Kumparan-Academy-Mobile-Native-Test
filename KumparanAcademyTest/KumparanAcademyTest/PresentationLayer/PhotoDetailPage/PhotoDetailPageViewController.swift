//
//  PhotoDetailPageViewController.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import UIKit

final class PhotoDetailPageViewController: UIViewController {
    
    @IBOutlet weak var fullSizePhotoImageOutlet: UIImageView!
    @IBOutlet weak var photoTitleLabelOutlet: UILabel!
    
    var photoName: String = ""
    var photoOriginalURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullSizePhotoImageOutlet.layer.cornerRadius = 16
        fullSizePhotoImageOutlet.setImageFrom(photoOriginalURL)
        photoTitleLabelOutlet.text = photoName
    }
}
