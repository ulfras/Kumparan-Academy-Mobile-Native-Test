//
//  AlbumDetailCollectionCell.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import UIKit

final class AlbumDetailCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photosImageOutlet: UIImageView!
    @IBOutlet weak var photosNameLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photosImageOutlet.layer.cornerRadius = 8
        photosImageOutlet.layer.borderColor = UIColor.systemGray3.cgColor
        photosImageOutlet.layer.borderWidth = 1
    }
}
