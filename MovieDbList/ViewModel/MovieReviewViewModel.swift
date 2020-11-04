//
//  MovieReviewViewModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation

class MovieReviewViewModel {
    var moviesReviewArray: [MovieReviewModel] = [MovieReviewModel]()
    var hasMore:Bool = false
    var isLoading:Bool = false
    var nextRequestPage = 1
    var currentPage = 1
    var bindMovieReviewViewModelToController : (() -> ())?
    var onErrorHandling : ((APIError?) -> Void)?
    var movieId:Int?
    init(movieId:Int) {
        self.movieId = movieId
    }
}
// API call
extension MovieReviewViewModel {
    func loadMovieReviewAPI(){
        isLoading = true
        ReviewRequest(page: self.nextRequestPage, movieId: self.movieId).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.onReviewSuccess(response: response)
                break
            case .failure(let error):
                self?.onReviewMoviesError(error: error)
                break
            }
        }
    }
}
// Send updates to view
extension MovieReviewViewModel{
    func onReviewSuccess(response: ReviewResponse) {
        if response.page == 1 {
            self.moviesReviewArray.removeAll()
            self.moviesReviewArray = response.results
        } else {
            self.moviesReviewArray.append(contentsOf: response.results)
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
        self.bindMovieReviewViewModelToController?()
    }
    func onReviewMoviesError(error: APIError) {
        self.isLoading = false
        self.onErrorHandling?(error)
    }
}
extension MovieReviewViewModel {
    func numberOfRows()-> Int {
        return moviesReviewArray.count
    }
    func numberOfSections()-> Int {
        return 1
    }
    func canLoadNow(index: Int) -> Bool {
        return (index == moviesReviewArray.count - 2) && !isLoading && hasMore
    }
}
