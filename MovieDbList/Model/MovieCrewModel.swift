//
//  MovieCrewModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation

struct MovieCrewModel : Codable {
    
    let creditId : String?
    let department : String?
    let gender : Int?
    let id : Int?
    let job : String?
    let name : String?
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
        case creditId = "credit_id"
        case department = "department"
        case gender = "gender"
        case id = "id"
        case job = "job"
        case name = "name"
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
        department = try values.decodeIfPresent(String.self, forKey: .department)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        job = try values.decodeIfPresent(String.self, forKey: .job)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
    }
    
}
