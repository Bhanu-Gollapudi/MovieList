//
//  MovieDetailViewModelStateTest.swift
//  MovieListTests
//
//  Created by Bhanu Prasad Gollapudi on 05/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import XCTest
@testable import MovieList
var movieDetailVC : MovieDetailsViewController?
class MovieDetailViewModelStateTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                      movieDetailVC = (storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController)
                      movieDetailVC!.performSelector(onMainThread: #selector(UIViewController.loadView), with: nil, waitUntilDone: true)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieDetailVC?.movieDetails = nil
        movieDetailVC = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
           
            
        }
    }

    func testScalingProducesSameAmountOfImages() {
        let movDetails = MovieDetails(movieTitle: "XYZ",
                                      movieCategory: "Drama",
                                      movieReleaseDate: "November 27",
                                      movieThumbnailImage: "",
                                      movieSummary: "pqr",
                                      detailImage: "",
                                      movieCount: 0)
        
        
         XCTAssertNotNil(movDetails)
        movieDetailVC?.movieDetails = movDetails
        movieDetailVC?.viewDidLoad()
    }

}
