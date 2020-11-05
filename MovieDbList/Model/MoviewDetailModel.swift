//
//  MoviewDetailModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
import UIKit

struct MoviewDetailModel: Codable {
    
    let adult : Bool?
    let backdropPath : String?
    let budget : Int?
    let genres : [MoviewDetailModelGenre]?
    let homepage : String?
    let id : Int?
    let imdbId : String?
    let originalLanguage : String?
    let originalTitle : String?
    let overview : String?
    let popularity : Float?
    let posterPath : String?
    let productionCompanies : [MoviewDetailModelProductionCompany]?
    let productionCountries : [MoviewDetailModelProductionCountry]?
    let releaseDate : String?
    let revenue : Int?
    let runtime : Int?
    let spokenLanguages : [MoviewDetailModelSpokenLanguage]?
    let status : String?
    let tagline : String?
    let title : String?
    let video : Bool?
    let voteAverage : Float?
    let voteCount : Int?
    // get Image Full path
    var fullPosterPath: String? {
        if let path = self.posterPath {
            return "\(Constant.MOVIE_DB_IMAGE_BASE_PATH)\(path)"
        } else{
            return nil
        }
    }
    var fullBackdropPath: String? {
        if let path = self.backdropPath {
            return "\(Constant.MOVIE_DB_IMAGE_BASE_PATH)\(path)"
        } else{
            return nil
        }
    }
    enum CodingKeys: String, CodingKey {
            case adult = "adult"
            case backdropPath = "backdrop_path"
            case budget = "budget"
            case genres = "genres"
            case homepage = "homepage"
            case id = "id"
            case imdbId = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview = "overview"
            case popularity = "popularity"
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            case releaseDate = "release_date"
            case revenue = "revenue"
            case runtime = "runtime"
            case spokenLanguages = "spoken_languages"
            case status = "status"
            case tagline = "tagline"
            case title = "title"
            case video = "video"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
    }

    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
            backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
            budget = try values.decodeIfPresent(Int.self, forKey: .budget)
            genres = try values.decodeIfPresent([MoviewDetailModelGenre].self, forKey: .genres)
            homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            imdbId = try values.decodeIfPresent(String.self, forKey: .imdbId)
            originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
            originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
            overview = try values.decodeIfPresent(String.self, forKey: .overview)
            popularity = try values.decodeIfPresent(Float.self, forKey: .popularity)
            posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
            productionCompanies = try values.decodeIfPresent([MoviewDetailModelProductionCompany].self, forKey: .productionCompanies)
            productionCountries = try values.decodeIfPresent([MoviewDetailModelProductionCountry].self, forKey: .productionCountries)
            releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
            revenue = try values.decodeIfPresent(Int.self, forKey: .revenue)
            runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
            spokenLanguages = try values.decodeIfPresent([MoviewDetailModelSpokenLanguage].self, forKey: .spokenLanguages)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            video = try values.decodeIfPresent(Bool.self, forKey: .video)
            voteAverage = try values.decodeIfPresent(Float.self, forKey: .voteAverage)
            voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
    }

}
class MoviewDetailModelSpokenLanguage : Codable {

        let iso6391 : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case iso6391 = "iso_639_1"
                case name = "name"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                iso6391 = try values.decodeIfPresent(String.self, forKey: .iso6391)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
class MoviewDetailModelProductionCountry : Codable {

        let iso31661 : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case iso31661 = "iso_3166_1"
                case name = "name"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                iso31661 = try values.decodeIfPresent(String.self, forKey: .iso31661)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
class MoviewDetailModelProductionCompany : Codable {

        let id : Int?
        let logoPath : String?
        let name : String?
        let originCountry : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case logoPath = "logo_path"
                case name = "name"
                case originCountry = "origin_country"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                logoPath = try values.decodeIfPresent(String.self, forKey: .logoPath)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                originCountry = try values.decodeIfPresent(String.self, forKey: .originCountry)
        }

}
class MoviewDetailModelGenre : Codable {

        let id : Int?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
