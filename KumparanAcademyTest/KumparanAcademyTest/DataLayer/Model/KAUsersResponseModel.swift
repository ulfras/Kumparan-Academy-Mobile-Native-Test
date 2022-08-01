//
//  KAUsersResponseModel.swift
//  KumparanAcademyTest
//
//  Created by Maulana Frasha on 02/08/22.
//

struct KAUsersResponseModel: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }
}

// MARK: - Address
struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    
    enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
    }
}

// MARK: - Company
struct Company: Decodable {
    let name: String?
    let catchPhrase: String?
    let bs: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}

