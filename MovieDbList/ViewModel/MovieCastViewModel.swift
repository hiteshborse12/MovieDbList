//
//  MovieCastViewModel.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import Foundation
class MovieCastViewModel {
    var movieCastArray: [MovieCastModel] = [MovieCastModel]()
    var bindMovieCastViewModelToController : (() -> ())?
    var onErrorHandling : ((APIError?) -> Void)?
    var movieId:Int?
    init(movieId:Int) {
        self.movieId = movieId
    }
}
// API call
extension MovieCastViewModel {
    func loadMovieCastAPI(){
        CreditsRequest(movieId: self.movieId).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.onCreditsRequestSuccess(response: response)
                break
            case .failure(let error):
                self?.onCreditsRequestError(error: error)
                break
            }
        }
    }
}
// Send updates to view
extension MovieCastViewModel{
    func onCreditsRequestSuccess(response: CreditsResponse) {
        self.movieCastArray.removeAll()
        self.movieCastArray = response.casts
        self.bindMovieCastViewModelToController?()
    }
    func onCreditsRequestError(error: APIError) {
        self.onErrorHandling?(error)
    }
}
extension MovieCastViewModel {
    func numberOfRows()-> Int {
        return movieCastArray.count
    }
    func numberOfSections()-> Int {
        return 1
    }
}
