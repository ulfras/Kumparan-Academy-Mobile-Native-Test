//
//  DetailPostPageViewController.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import UIKit

final class DetailPostPageViewController: UIViewController {
    
    @IBOutlet weak var postsTitleLabelOutlet: UILabel!
    @IBOutlet weak var postsBodyTextViewOutlet: UITextView!
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet var detailPostTableView: UITableView!
    
    var postIDDetailPage: Int = 0
    var postTitleDetailPage: String = ""
    var postBodyDetailPage: String = ""
    var userNameDetailPage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        detailPageDesign()
        
        detailPostTableView.register(UINib.init(nibName:"DetailPostPageCell" , bundle: nil), forCellReuseIdentifier: "DetailPostPageCell")
        detailPostTableView.delegate = self
        detailPostTableView.dataSource = self
    }
    
    private func detailPageDesign() {
        postsBodyTextViewOutlet.layer.borderWidth = 1
        postsBodyTextViewOutlet.layer.borderColor = UIColor.black.cgColor
        postsBodyTextViewOutlet.layer.cornerRadius = 8
        
        postsTitleLabelOutlet.text = postTitleDetailPage
        postsBodyTextViewOutlet.text = postBodyDetailPage
        usernameLabelOutlet.text = userNameDetailPage
    }
}

extension DetailPostPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "DetailPostPageCell",
            for: indexPath
        )
        
        return reusableCell
    }
}
