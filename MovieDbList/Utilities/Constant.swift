//
//  Constant.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//


import Foundation
import UIKit
class Constant {
    private init() {}
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let MOVIE_DB_BASE_PATH = "https://api.themoviedb.org/3/movie"
    static let MOVIE_DB_IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/original"
    static let API_KEY = "c5f28957ed0174811a928be9c3b3f339"
    static let RECENT_MAXIMUM = 5
}
