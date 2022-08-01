//
//  KAPostsResponseModel.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 01/08/22.
//

struct KAPostsResponseModel: Decodable {
    let userID: Int?
    let id: Int?
    let title: String?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
}
