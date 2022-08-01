//
//  DetailPostPageCell.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import UIKit

final class DetailPostPageCell: UITableViewCell {

    @IBOutlet weak var commentAuthorLabelOutlet: UILabel!
    @IBOutlet weak var postsCommentsBodyTextViewOutlet: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postsCommentsBodyTextViewOutlet.layer.borderWidth = 1
        postsCommentsBodyTextViewOutlet.layer.borderColor = UIColor.black.cgColor
        postsCommentsBodyTextViewOutlet.layer.cornerRadius = 8
        postsCommentsBodyTextViewOutlet.isEditable = false
    }
}
