//
//  ListPostPageViewController.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 01/08/22.
//

import UIKit

final class ListPostPageViewController: UITableViewController {
    
    @IBOutlet var listPostPageTableViewOutlet: UITableView!
    
    private let callPostsAPI = KAPostsAPI()
    private let callUsersAPI = KAUsersAPI()
    var postsData: [KAPostsResponseModel] = []
    var usersData: [KAUsersResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        listPostPageTableViewSource()
        
        callPostsAPI.getPostsKA { result in
            switch result {
            case let .success(data):
                self.postsData.append(contentsOf: data)
                self.tableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        callUsersAPI.getUsersKA { result in
            switch result {
            case let .success(data):
                self.usersData.append(contentsOf: data)
                self.tableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func listPostPageTableViewSource() {
        listPostPageTableViewOutlet.delegate = self
        listPostPageTableViewOutlet.dataSource = self
        listPostPageTableViewOutlet.register(UINib.init(nibName:"ListPostPageCell" , bundle: nil), forCellReuseIdentifier: "ListPostPageCell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 261
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "ListPostPageCell",
            for: indexPath
        )
        guard let cell = reusableCell as? ListPostPageCell else { return reusableCell }
        
        let postsDataCell = postsData[indexPath.row]
        cell.postsTitleLabelOutlet.text = "Post Title: \(postsDataCell.title ?? "Post Title: ")"
        cell.postsBodyTextViewOutlet.text = "Post Body: \(postsDataCell.body ?? "Post Body: ")"
        cell.userIDCell = postsDataCell.userID!
        for _ in postsData {
            for i in usersData {
                if postsDataCell.userID == i.id {
                    cell.usernameLabelOutlet.text = "User Name: \(i.name ?? "User Name:" )"
                    cell.companyNameLabelOutlet.text = "Company Name: \(i.company?.name ?? "Company Name:")"
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPageViewController = UIStoryboard(name: "DetailPostPageViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailPostPageViewController") as! DetailPostPageViewController
        let postsDataCell = postsData[indexPath.row]
        detailPageViewController.postIDDetailPage = postsDataCell.id ?? 0
        detailPageViewController.postTitleDetailPage = postsDataCell.title ?? "Post Title: "
        detailPageViewController.postBodyDetailPage = postsDataCell.body ?? "Post Body: "
        for _ in postsData {
            for i in usersData {
                if postsDataCell.userID == i.id {
                    detailPageViewController.userNameDetailPage = i.name ?? "User Name:"
                }
            }
        }
        self.navigationController?.pushViewController(detailPageViewController, animated: true)
    }
}


