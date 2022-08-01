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
    
    private let callUsersAPI = KAUsersAPI()
    var userIDUserDetailPage: Int = 0
    
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
        
    }
}
