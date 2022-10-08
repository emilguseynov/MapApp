// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct MapAnnotationModel: Codable {
    let idClient, idClientAccount: Int
    let clientCode: String
    let latitude, longitude: Double
    let avatarHash: String?
    let statusOnline: Bool

    enum CodingKeys: String, CodingKey {
        case idClient = "IdClient"
        case idClientAccount = "IdClientAccount"
        case clientCode = "ClientCode"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case avatarHash = "AvatarHash"
        case statusOnline = "StatusOnline"
    }
}



