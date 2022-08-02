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
    
    private let callPostCommentAPI = KAPostCommentAPI()
    private var postCommentData: [KAPostCommentResponseModel] = []
    var postIDDetailPage: Int = 0
    var userIDDetailPage: Int = 0
    var postTitleDetailPage: String = ""
    var postBodyDetailPage: String = ""
    var userNameDetailPage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        detailPageDesign()
        detailPostPageTableViewSource()
        callPostCommentAPI.getPostCommentKA(postID: postIDDetailPage) { result in
            switch result {
            case let .success(data):
                self.postCommentData.append(contentsOf: data)
                self.detailPostTableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func detailPageDesign() {
        postsBodyTextViewOutlet.layer.borderWidth = 1
        postsBodyTextViewOutlet.layer.borderColor = UIColor.black.cgColor
        postsBodyTextViewOutlet.layer.cornerRadius = 8
        postsBodyTextViewOutlet.isEditable = false
        
        postsTitleLabelOutlet.text = "Post Title: \(postTitleDetailPage)"
        postsBodyTextViewOutlet.text = "Post Body: \(postBodyDetailPage)"
        usernameLabelOutlet.text = "User Name: \(userNameDetailPage)"
        
        usernameLabelOutlet.textColor = .systemBlue
        usernameLabelOutlet.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailPostPageViewController.userNameTapsender))
        usernameLabelOutlet.addGestureRecognizer(tap)
    }
    
    private func detailPostPageTableViewSource() {
        detailPostTableView.register(
            UINib.init(nibName:"DetailPostPageCell",bundle: nil),
            forCellReuseIdentifier: "DetailPostPageCell"
        )
        detailPostTableView.delegate = self
        detailPostTableView.dataSource = self
    }
    
    
    @objc func userNameTapsender(sender: UITapGestureRecognizer) {
        let userDetailPageViewController = UIStoryboard(name: "UserDetailPageViewController", bundle: nil).instantiateViewController(withIdentifier: "UserDetailPageViewController") as! UserDetailPageViewController
        userDetailPageViewController.userIDUserDetailPage = userIDDetailPage
        self.navigationController?.pushViewController(userDetailPageViewController, animated: true)
    }
}

extension DetailPostPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postCommentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "DetailPostPageCell",
            for: indexPath
        ) as! DetailPostPageCell
        guard let cell = reusableCell as? DetailPostPageCell else { return reusableCell }
        
        let postCommentDataCell = postCommentData[indexPath.row]
        cell.selectionStyle = .none
        cell.commentAuthorLabelOutlet.text = "Comment Author: \(postCommentDataCell.name ?? "Comment Author:")"
        cell.postsCommentsBodyTextViewOutlet.text = "Comment Body: \(postCommentDataCell.body ?? "Comment Body:")"
        
        return cell
    }
}
