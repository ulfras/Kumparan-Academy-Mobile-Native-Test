//
//  PhotoDetailPageViewController.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import UIKit

protocol SubclassedDelegate: AnyObject {
    func zooming(started: Bool)
}

final class PhotoDetailPageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var fullSizePhotoImageOutlet: UIImageView!
    @IBOutlet weak var photoTitleLabelOutlet: UILabel!
    
    weak var delegate: SubclassedDelegate?
    var photoName: String = ""
    var photoOriginalURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullSizePhotoImageOutlet.layer.cornerRadius = 16
        fullSizePhotoImageOutlet.setImageFrom(photoOriginalURL)
        photoTitleLabelOutlet.text = photoName
        addGesture()
    }
    
    private func addGesture() {
        fullSizePhotoImageOutlet.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(
            target: self,
            action: #selector(self.didPinch))
        fullSizePhotoImageOutlet.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        gesture.view?.transform = (gesture.view?.transform.scaledBy(
            x: gesture.scale,
            y: gesture.scale))!
        gesture.scale = 1.0
    }
}
