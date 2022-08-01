//
//  ListPostPageCell.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 01/08/22.
//

import UIKit

final class ListPostPageCell: UITableViewCell {
    
    @IBOutlet weak var postsTitleLabelOutlet: UILabel!
    @IBOutlet weak var postsBodyTextViewOutlet: UITextView!
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet weak var companyNameLabelOutlet: UILabel!
    var userIDCell: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postsBodyTextViewOutlet.layer.borderWidth = 1
        postsBodyTextViewOutlet.layer.borderColor = UIColor.black.cgColor
        postsBodyTextViewOutlet.layer.cornerRadius = 8
    }
}
