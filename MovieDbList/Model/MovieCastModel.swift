//
//  MovieCastModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation

class MovieCastModel : Codable {
    
    let castId : Int?
    let character : String?
    let creditId : String?
    let gender : Int?
    let id : Int?
    let name : String?
    let order : Int?
    let profilePath : String?
    // get Image Full path
    var fullProfilePath: String? {
        if let path = self.profilePath {
            return "\(Constant.MOVIE_DB_IMAGE_BASE_PATH)\(path)"
        } else{
            return nil
        }
    }
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case character = "character"
        case creditId = "credit_id"
        case gender = "gender"
        case id = "id"
        case name = "name"
        case order = "order"
        case profilePath = "profile_path"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        castId = try values.decodeIfPresent(Int.self, forKey: .castId)
        character = try values.decodeIfPresent(String.self, forKey: .character)
        creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
    }
    
}
