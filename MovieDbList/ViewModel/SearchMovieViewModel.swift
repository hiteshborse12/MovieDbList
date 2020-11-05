//
//  SearchMovieViewModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
class SearchMovieViewModel {
    var movieViewModel : MovieViewModel?
    var searchMovieArray = [MovieModel]()
    var bindSearchMovieViewModelToController : (() -> ())?
    var isRecentSearch = true
    init(movieViewModel:MovieViewModel?) {
        self.movieViewModel = movieViewModel
    }
}
// filter Movie
extension SearchMovieViewModel {
    func searchMovie(text:String){
        searchMovieArray.removeAll()
        if text.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            //Get past saved movie list
            isRecentSearch = true
            getMovieForRecentSearch()
        }else {
            isRecentSearch = false
            // Search for movies in the movie list
            searchMovieArray = text.searchMovies(movies: movieViewModel?.moviesArray ?? [MovieModel]())
        }
        self.onSearchMovie()
    }
}
// Send updates to view
extension SearchMovieViewModel{
    func onSearchMovie() {
        self.bindSearchMovieViewModelToController?()
    }
}
extension SearchMovieViewModel {
    func numberOfRows()-> Int {
        return searchMovieArray.count
    }
    func numberOfSections()-> Int {
        return 1
    }
    func savMovieForRecentSearch(movie:MovieModel) {
        DataBaseManager().saveNewsMovie(movie: movie)
    }
    func getMovieForRecentSearch() {
        searchMovieArray = DataBaseManager().getRecentMovie()
    }
    func isShowRecentSearch()-> Bool {
        if isRecentSearch && searchMovieArray.count > 0{
            return true
        }
        return false
    }
}
