//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by Bhanu Prasad Gollapudi on 03/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import XCTest
@testable import MovieList
var movieListVC: MovieListViewController?

class MovieListTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        movieListVC = (storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController)
        movieListVC!.performSelector(onMainThread: #selector(UIViewController.loadView), with: nil, waitUntilDone: true)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieListVC = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //self.testParentViewHasTableViewSubview()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testParentViewHasTableViewSubview() {
        XCTAssertNotNil(movieListVC)
        let subviews = movieListVC!.view.subviews
        XCTAssertFalse(subviews.contains(movieListVC!.movieListView), "View does not have a table subview")
    }

    func testHasATableView() {
        XCTAssertNotNil(movieListVC?.movieListView)
    }

    func testTableViewHasDelegate() {
        XCTAssertNotNil(movieListVC)
        XCTAssertNotNil(movieListVC!.tableView.delegate)
    }

    func testThatTableViewLoads() {
        XCTAssertNotNil(movieListVC)
        XCTAssertNotNil(movieListVC!.tableView, "TableView not initiated")
    }
    
    func testThatTableViewHasDataSource() {
        XCTAssertNotNil(movieListVC)
        XCTAssertNotNil(movieListVC!.movieListView.dataSource, "Table datasource cannot be nil")
    }

    func testThatViewConformsToUITableViewDelegate() {
        XCTAssertTrue(movieListVC != nil, "View does not conform to UITableView delegate protocol")
    }

    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(movieListVC)
        XCTAssertNotNil(movieListVC!.movieListView.delegate, "Table delegate cannot be nil")
    }

    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertNotNil(movieListVC)
        XCTAssertTrue(movieListVC!.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(movieListVC!.responds(to: #selector(movieListVC!.tableView(_:didSelectRowAt:))))
    }

    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertNotNil(movieListVC)
        XCTAssertTrue(movieListVC!.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(movieListVC!.responds(to: #selector(movieListVC!.numberOfSections(in:))))
        XCTAssertTrue(movieListVC!.responds(to: #selector(movieListVC!.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(movieListVC!.responds(to: #selector(movieListVC!.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewDidSelectRowAtIndexPath() {
        XCTAssertNotNil(movieListVC)
        XCTAssertNotNil(movieListVC!.movieDetail, "Should contains MovieDetails")
    }
}
