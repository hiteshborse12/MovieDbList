//
//  CreditsRequest.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
class CreditsResponse: Codable {
    
    var casts: [MovieCastModel] = []
    
    enum CodingKeys: String, CodingKey {
        case casts = "cast"
    }
    
}

class CreditsRequest: APIRequest<CreditsResponse> {
    init(movieId:Int? = nil) {
        super.init(route: MovieRoute.getMovieCredits.asRoute(movieId:movieId))
    }
}
