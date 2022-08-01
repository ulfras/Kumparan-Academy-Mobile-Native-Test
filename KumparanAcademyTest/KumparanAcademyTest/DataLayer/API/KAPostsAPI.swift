//
//  KAPostsAPI.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 01/08/22.
//

import Alamofire

class KAPostsAPI {
    func getPostsKA(completionHandler: @escaping (Result<[KAPostsResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAPostsResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
}
