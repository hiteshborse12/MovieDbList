//
//  MovieRoute.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import Foundation

enum MovieRoute {
    case getNowPlaying
    case getMovieDetails
    case getMovieReviews
    case getMovieCredits
    case getSimilarMovies
}

extension MovieRoute {
    
    private var baseUrl: String {
        return Constant.MOVIE_DB_BASE_PATH
    }
    private func apiEndPoint(movieId:Int? = nil) -> String {
        let path = urlPath.count > 0 ?  "/\(urlPath)" : ""
        let movieid = (movieId != nil)  ?  "/\(movieId ?? 0)" : ""
        return "\(baseUrl)\(movieid)\(path)?api_key=\(Constant.API_KEY)"
    }
    
    private var urlPath: String {
        switch self {
        case .getNowPlaying:
            return "now_playing"
        case .getMovieDetails:
            return ""
        case .getMovieReviews:
            return "reviews"
        case .getMovieCredits:
            return "credits"
        case .getSimilarMovies:
            return "similar"
        }
    }
    
    var url: URL {
        return URL(string: apiEndPoint())!
    }
    // Return Route with API endpoint
    func asRoute(movieId:Int? = nil) -> Route {
        switch self {
        case .getNowPlaying:
            return Route.getRoute(path: apiEndPoint())
        case .getMovieDetails:
            return Route.getRoute(path: apiEndPoint(movieId:movieId))
        case .getMovieReviews:
            return Route.getRoute(path: apiEndPoint(movieId:movieId))
        case .getMovieCredits:
            return Route.getRoute(path: apiEndPoint(movieId:movieId))
        case .getSimilarMovies:
            return Route.getRoute(path: apiEndPoint(movieId:movieId))
        }
    }
}
