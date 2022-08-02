//
//  KAPhotosResponseModel.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

struct KAPhotosResponseModel: Codable {
    let albumID: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailURL = "thumbnailUrl"
    }
}
