//
//  SimilarMovieViewModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
class SimilarMovieViewModel {
    var moviesArray: [MovieModel] = [MovieModel]()
    var hasMore:Bool = false
    var isLoading:Bool = false
    var nextRequestPage = 1
    var currentPage = 1
    var bindSimilarMovieViewModelToController : (() -> ())?
    var onErrorHandling : ((APIError?) -> Void)?
    var movieId:Int?
    init(movieId:Int?) {
        self.movieId = movieId
    }
}
// API call
extension SimilarMovieViewModel {
    func loadSimilarMovieAPI(){
        isLoading = true
        SimilarMoviesRequest(page: self.nextRequestPage, movieId: self.movieId).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.onSimilarMoviesSuccess(response: response)
                break
            case .failure(let error):
                self?.onSimilarMoviesError(error: error)
                break
            }
        }
    }
}
// Send updates to view
extension SimilarMovieViewModel{
    func onSimilarMoviesSuccess(response: SimilarMoviesResponse) {
        if response.page == 1 {
            self.moviesArray.removeAll()
            self.moviesArray = response.results
        } else {
            self.moviesArray.append(contentsOf: response.results)
        }
        currentPage = response.page
        if response.page >= response.totalPages {
            hasMore = false
        }
        else {
            hasMore = true
            nextRequestPage = response.page + 1
        }
        self.isLoading = false
        self.bindSimilarMovieViewModelToController?()
    }
    func onSimilarMoviesError(error: APIError) {
        self.isLoading = false
        self.onErrorHandling?(error)
    }
}
extension SimilarMovieViewModel {
    func numberOfRows()-> Int {
        return moviesArray.count
    }
    func numberOfSections()-> Int {
        return 1
    }
    func canLoadNow(index: Int) -> Bool {
        return (index == moviesArray.count - 2) && !isLoading && hasMore
    }
}
