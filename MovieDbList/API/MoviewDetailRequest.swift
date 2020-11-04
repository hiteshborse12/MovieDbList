//
//  MoviewDetailRequest.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation

class MoviewDetailResponse: Codable {
    
    var results: MoviewDetailModel?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

class MoviewDetailRequest: APIRequest<MoviewDetailModel> {
    
    init(movieId:Int? = nil) {
        super.init(route: MovieRoute.getMovieDetails.asRoute(movieId: movieId))
    }
    
}
