//
//  KAPostCommentAPI.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

import Alamofire

class KAPostCommentAPI {
    func getPostCommentKA(postID: Int, completionHandler: @escaping (Result<[KAPostCommentResponseModel], AFError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/comments?postId=\(postID)"
        AF.request(url, method: .get)
            .responseDecodable(of: [KAPostCommentResponseModel].self) { response in
                completionHandler(response.result)
        }
    }
}
