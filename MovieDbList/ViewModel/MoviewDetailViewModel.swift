//
//  MoviewDetailViewModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
class MoviewDetailViewModel {
    var moviewDetail: MoviewDetailModel?
    var similarMovieViewModel: SimilarMovieViewModel?
    var movie: MovieModel?
    var isLoading:Bool = false
    var bindMoviewDetailViewModelToController : (() -> ())?
    var onErrorHandling : ((APIError?) -> Void)?
    init(movie:MovieModel?) {
        self.movie = movie
    }
}
// API call
extension MoviewDetailViewModel {
    func loadMoviewDetail(){
        isLoading = true
        MoviewDetailRequest(movieId: self.movie?.id).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.onMoviewDetailRequestSuccess(response: response)
                break
            case .failure(let error):
                self?.onMoviewDetailRequestError(error: error)
                break
            }
        }
    }
}
// Send updates to view
extension MoviewDetailViewModel{
    func onMoviewDetailRequestSuccess(response: MoviewDetailModel) {
        self.isLoading = false
        self.moviewDetail = response
        self.bindMoviewDetailViewModelToController?()
    }
    func onMoviewDetailRequestError(error: APIError) {
        self.isLoading = false
        self.onErrorHandling?(error)
    }
}
extension MoviewDetailViewModel {
    func isMoviewDetail()-> Bool {
        if self.moviewDetail != nil{
            return true
        }
        return false
    }
}
