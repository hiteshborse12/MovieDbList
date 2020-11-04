//
//  SimilarMoviesRequest.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
class SimilarMoviesResponse: Codable {
    
    var page: Int = 1
    var totalResults: Int = 0
    var totalPages: Int = 0
    var results: [MovieModel] = []
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
}

class SimilarMoviesRequest: APIRequest<SimilarMoviesResponse> {
    
    private var page: Int = 1
    
    init(page: Int,movieId:Int? = nil) {
        super.init(route: MovieRoute.getSimilarMovies.asRoute(movieId:movieId))
        self.page = page
    }
    
    override func getParameters() -> [String : Any] {
        return [
            "page": self.page
        ]
    }
    
}
