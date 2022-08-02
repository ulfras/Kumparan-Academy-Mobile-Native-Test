//
//  KAAlbumsAPI.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import Alamofire

class KAAlbumsAPI {
    func getAlbumsKA(completionHandler: @escaping (Result<[KAAlbumsResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/albums"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAAlbumsResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
    
    func getAlbumsKA(id: Int, completionHandler: @escaping (Result<[KAAlbumsResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/albums?userId=\(id)"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAAlbumsResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
}
