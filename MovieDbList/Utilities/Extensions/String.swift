//
//  String.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
extension String{
    
    // Search for movies in the movie list
    func searchMovies(movies:[MovieModel]) -> [MovieModel]{
        // Split search string into non empty string array
        let searchArray  = self.components(separatedBy: .whitespacesAndNewlines).filter {
            if ($0.count > 0) {
                return true
            }
            return false
        }
        // Get final matched movie arrray
        let matchedMovieArray =  movies.filter { (movie) -> Bool in
            
            // Get array of matched search text found in movie title
            let matchedSearchs = searchArray.filter { (searchText) -> Bool in
                
                // Return true only if movie title any sub string start search text
                return movie.title?.isStringStartWith(subString: searchText) ?? false
            }
            
            // Return true only if movie title contains all search text
            return (matchedSearchs.count > 0  && matchedSearchs.count >= searchArray.count)
        }
        return matchedMovieArray
    }
    
    // Check if string start with subString
    func isStringStartWith(subString:String) -> Bool {
        let result = self.components(separatedBy: .whitespacesAndNewlines).filter { (string) -> Bool in
            // Check string prefix
            if string.lowercased().hasPrefix(subString.lowercased()){
                return true
            }
            return false
        }
        return (result.count > 0)
    }
    
}
