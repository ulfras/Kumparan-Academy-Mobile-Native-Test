//
//  ListPostPageViewController.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 01/08/22.
//

import UIKit

final class ListPostPageViewController: UITableViewController {
    
    @IBOutlet var listPostPageTableViewOutlet: UITableView!
    
    let callPostsAPI = KAPostsAPI()
    var postsData: [KAPostsResponseModel] = []
    
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
        
    }
    
    private func listPostPageTableViewSource() {
        listPostPageTableViewOutlet.delegate = self
        listPostPageTableViewOutlet.dataSource = self
        listPostPageTableViewOutlet.register(UINib.init(nibName:"ListPostPageCell" , bundle: nil), forCellReuseIdentifier: "ListPostPageCell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 253
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "ListPostPageCell",
            for: indexPath
        )
        
        return reusableCell
    }
}


