//
//  ReviewRequest.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
class ReviewResponse: Codable {
    
    var page: Int = 1
    var totalResults: Int = 0
    var totalPages: Int = 0
    var results: [MovieReviewModel] = []
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
}

class ReviewRequest: APIRequest<ReviewResponse> {
    
    private var page: Int = 1
    
    init(page: Int,movieId:Int? = nil) {
        super.init(route: MovieRoute.getMovieReviews.asRoute(movieId:movieId))
        self.page = page
    }
    
    override func getParameters() -> [String : Any] {
        return [
            "page": self.page
        ]
    }
    
}
