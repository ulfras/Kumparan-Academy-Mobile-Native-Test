//
//  KAPhotosAPI.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import Alamofire

class KAPhotosAPI {
    func getPhotosKA(completionHandler: @escaping (Result<[KAPhotosResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/photos"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAPhotosResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
    
    func getPhotosKA(id: Int, completionHandler: @escaping (Result<[KAPhotosResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/photos?albumId=\(id)"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAPhotosResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
}
