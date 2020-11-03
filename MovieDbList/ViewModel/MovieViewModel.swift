//
//  MovieViewModel.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import Foundation
class MovieViewModel {
    var moviesArray: [MovieModel] = [MovieModel]()
    var hasMore:Bool = false
    var isLoading:Bool = false
    var nextRequestPage = 1
    var currentPage = 1
    var bindMovieViewModelToController : (() -> ())?
    var onErrorHandling : ((APIError?) -> Void)?
}
extension MovieViewModel {
    func loadNowPlaying(){
        isLoading = true
        NowPlayingRequest(page: self.nextRequestPage).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.onNowPlayingRequestSuccess(response: response)
                break
            case .failure(let error):
                self?.onNowPlayingRequestError(error: error)
                break
            }
        }
    }
    func reloadNowPlaying(){
        isLoading = true
        self.nextRequestPage = 1
        NowPlayingRequest(page: self.nextRequestPage).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.onNowPlayingRequestSuccess(response: response)
                break
            case .failure(let error):
                self?.onNowPlayingRequestError(error: error)
                break
            }
        }
    }
}
extension MovieViewModel{
    func onNowPlayingRequestSuccess(response: NowPlayingResponse) {
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
        self.bindMovieViewModelToController?()
    }
    func onNowPlayingRequestError(error: APIError) {
        self.isLoading = false
        self.onErrorHandling?(error)
    }
}
extension MovieViewModel {
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
