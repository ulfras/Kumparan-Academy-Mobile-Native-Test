//
//  KAAlbumsResponseModel.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

struct KAAlbumsResponseModel: Decodable {
    let userID: Int?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id = "id"
        case title = "title"
    }
}
