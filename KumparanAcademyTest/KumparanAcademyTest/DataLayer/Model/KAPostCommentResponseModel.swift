//
//  KAPostCommentResponseModel.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//
import Foundation

struct KAPostCommentResponseModel: Decodable {
    let postID: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id = "id"
        case name = "name"
        case email = "email"
        case body = "body"
    }
}
