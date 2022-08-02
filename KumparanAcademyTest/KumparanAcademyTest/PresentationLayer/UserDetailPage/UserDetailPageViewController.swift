//
//  UserDetailPageViewController.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import UIKit

final class UserDetailPageViewController: UIViewController {
    
    @IBOutlet weak var userNameLabelOutlet: UILabel!
    @IBOutlet weak var userEmailLabelOutlet: UILabel!
    @IBOutlet weak var userAddressLabelOutlet: UILabel!
    @IBOutlet weak var userCompanyLabelOutlet: UILabel!
    @IBOutlet weak var userDetailTableViewOutlet: UITableView!
    private let callUsersAPI = KAUsersAPI()
    var userIDUserDetailPage: Int = 0
    var storedOffsets = [Int: CGFloat]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callUsersAPI.getUsersKA(id: userIDUserDetailPage) { result in
            switch result {
            case let .success(data):
                self.userNameLabelOutlet.text = "User Name: \(data.first?.name ?? "User Name:")"
                self.userEmailLabelOutlet.text = "User Email: \(data.first?.email ?? "User Email:")"
                self.userAddressLabelOutlet.text = "User Address: \(data.first?.address?.street ?? "User Address:"), \(data.first?.address?.suite ?? ""), \(data.first?.address?.city ?? "")."
                self.userCompanyLabelOutlet.text = "User Company: \(data.first?.name ?? "User Company:")"
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailPageTableViewSource()
    }
    
    private func userDetailPageTableViewSource() {
        userDetailTableViewOutlet.delegate = self
        userDetailTableViewOutlet.dataSource = self
    }
}

extension UserDetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "UserDetailTableViewCell",
            for: indexPath
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? UserDetailTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? UserDetailTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

extension UserDetailPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailCollectionViewCell", for: indexPath) as! UserDetailCollectionViewCell
        
        reuseCollectionCell.tumbhnailImageOutlet.image = UIImage(named: "KumparanAcademyAppIcon")
        
        return reuseCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag + 1) selected index path \(indexPath.row + 1)")
    }
}
