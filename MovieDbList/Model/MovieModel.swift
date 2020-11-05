//
//  MovieModel.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import Foundation
import UIKit

struct MovieModel: Codable {
    
    var adult : Bool?
    var backdropPath : String?
    var genreIds : [Int]?
    var id : Int?
    var originalLanguage : String?
    var originalTitle : String?
    var overview : String?
    var popularity : Float?
    var posterPath : String?
    var releaseDate : String?
    var title : String?
    var video : Bool?
    var voteAverage : Float?
    var voteCount : Int?
    // get Image Full path
    var fullPosterPath: String? {
        if let path = self.posterPath {
            return "\(Constant.MOVIE_DB_IMAGE_BASE_PATH)\(path)"
        } else{
            return nil
        }
    }
    enum CodingKeys: String, CodingKey {
            case adult = "adult"
            case backdropPath = "backdrop_path"
            case genreIds = "genre_ids"
            case id = "id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview = "overview"
            case popularity = "popularity"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title = "title"
            case video = "video"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
    }
    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
            backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
            genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
            originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
            overview = try values.decodeIfPresent(String.self, forKey: .overview)
            popularity = try values.decodeIfPresent(Float.self, forKey: .popularity)
            posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
            releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            video = try values.decodeIfPresent(Bool.self, forKey: .video)
            voteAverage = try values.decodeIfPresent(Float.self, forKey: .voteAverage)
            voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
    }
    // Init from core data object
    init(from movie: Movie) {
        voteCount = movie.voteCount as? Int
        id = movie.id as? Int
        voteAverage = movie.voteAverage
        title = movie.title
        posterPath = movie.posterPath
        originalTitle = movie.originalTitle
        backdropPath = movie.backdropPath
        overview = movie.overview
        releaseDate = movie.releaseDate
    }
}
