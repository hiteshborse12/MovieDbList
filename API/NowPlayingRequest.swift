//
//  NowPlayingResponse.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import Foundation

class NowPlayingResponse: Codable {
    
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

class NowPlayingRequest: APIRequest<NowPlayingResponse> {
    
    private var page: Int = 1
    
    init(page: Int) {
        super.init(route: MovieRoute.getNowPlaying.asRoute())
        self.page = page
    }
    
    override func getParameters() -> [String : Any] {
        return [
            "page": self.page
        ]
    }
    
}
