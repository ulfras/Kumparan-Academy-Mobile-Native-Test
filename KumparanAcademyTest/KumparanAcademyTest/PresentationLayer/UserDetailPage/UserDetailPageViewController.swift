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
    private let callAlbumsAPI = KAAlbumsAPI()
    private let callPhotosAPI = KAPhotosAPI()
    private var albumsData: [KAAlbumsResponseModel] = []
    private var photosData: [KAPhotosResponseModel] = []
    var userIDUserDetailPage: Int = 0
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailPageTableViewSource()
        
        callUsersAPI.getUsersKA(id: userIDUserDetailPage) { result in
            switch result {
            case let .success(data):
                self.userNameLabelOutlet.text = "User Name: \(data.first?.name ?? "-")"
                self.userEmailLabelOutlet.text = "User Email: \(data.first?.email ?? "-")"
                self.userAddressLabelOutlet.text = "User Address: \(data.first?.address?.street ?? "-"), \(data.first?.address?.suite ?? "-"), \(data.first?.address?.city ?? "-")."
                self.userCompanyLabelOutlet.text = "User Company: \(data.first?.name ?? "-")"
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        callAlbumsAPI.getAlbumsKA(id: userIDUserDetailPage) { result in
            switch result {
            case let .success(data):
                self.albumsData.append(contentsOf: data)
                self.userDetailTableViewOutlet.reloadData()
                for albumsDatum in self.albumsData {
                    self.callPhotosAPI.getPhotosKA(id: albumsDatum.id!) { result in
                        switch result {
                        case let .success(data):
                            self.photosData.append(contentsOf: data)
                            self.userDetailTableViewOutlet.reloadData()
                        case let .failure(err):
                            print(err.localizedDescription)
                        }
                    }
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
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
        return albumsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "UserDetailTableViewCell",
            for: indexPath
        )
        guard let cell = reusableCell as? UserDetailTableViewCell else { return reusableCell }
        let albumsDataCell = albumsData[indexPath.row]
        cell.albumNameLabelOutlet.text = "Album Name: \(albumsDataCell.title ?? "-")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailViewController = UIStoryboard(name: "AlbumDetailPageViewController", bundle: nil).instantiateViewController(withIdentifier: "AlbumDetailPageViewController") as! AlbumDetailPageViewController
        let albumDataCell = albumsData[indexPath.row]
        albumDetailViewController.albumID = albumDataCell.id ?? 0
        albumDetailViewController.albumName = albumDataCell.title ?? ""
        self.navigationController?.pushViewController(albumDetailViewController, animated: true)
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
///        this code have an error with the first table cell return 0
//        var num = 0
//        for photosDatum in photosData {
//            if photosDatum.albumID == collectionView.tag {
//                let a = 0
//                num = a + 1
//            }
//        }
//        return num
        return 50
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

