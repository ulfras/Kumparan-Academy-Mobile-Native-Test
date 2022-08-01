//
//  KAUsersAPI.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import Alamofire

class KAUsersAPI {
    func getUsersKA(completionHandler: @escaping (Result<[KAUsersResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAUsersResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
    
    func getUsersKA(id: Int, completionHandler: @escaping (Result<[KAUsersResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users?id=\(id)"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAUsersResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
}
