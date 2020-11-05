//
//  MovieDbListTests.swift
//  MovieDbListTests
//
//  Created by webwerks on 03/11/20.
//

import XCTest
@testable import MovieDbList

class MovieDbListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testisValidMovieModel() {
        guard let data = JSONFrom(),
        let movie = MovieModel(jsonData: data) else {
            XCTFail("Json encode decod Error")
            return
        }
        var dateToDisplay = ""
        if let releaseData = CustomDateFormatter.dateFromString(dateFormat: .yyyyMMddHyphen, dateString: movie.releaseDate!){
            dateToDisplay = CustomDateFormatter.stringFromDate(dateFormat: .yyyyMMddHyphen,
                                                               dateToConvert: releaseData)
        }
        
        XCTAssert((type(of: movie) == MovieModel.self), "Invalid movie type")
        XCTAssertEqual(590223, movie.id, "Wrong movie id. Movie id must be '590223'")
        XCTAssertEqual(dateToDisplay, movie.releaseDate, "Date is wrong. Date must be '2020-10-16'")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func JSONFrom() -> Data? {
        let fileName = "movie"
        let pathURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json")
        guard let url = pathURL else {
            XCTFail("File not found '\(fileName)")
            return nil
        }

        guard let data = try? Data.init(contentsOf: url) else {
            XCTFail("Cannot convert json data")
            return nil
        }
        return data
    }
    
}
