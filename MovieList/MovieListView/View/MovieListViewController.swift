//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 03/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SplunkMint

struct MovieDetails {
    var movieTitle: String?
    var movieCategory: String?
    var movieReleaseDate: String?
    var movieThumbnailImage: String?
    var movieSummary: String?
    var detailImage: String?
    var movieCount: Int = 0
}

class MovieListViewController: UITableViewController, UISearchResultsUpdating {

    // MARK: -  IBOutlets -

    @IBOutlet var movieListView: UITableView!
    
    let disposeBag = DisposeBag()
    let searchController: UISearchController = UISearchController(searchResultsController: nil)

    var state: State!
    var viewModel: ViewModel!
    var activityIndicatorView = UIActivityIndicatorView()
    var movieDetail =  MovieDetails()

    // MARK: -  ViewLifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialViewSetUp()
    }
}

// MARK: - Private methods -

extension MovieListViewController {

    private func intialViewSetUp() {
        state = State()
        viewModel = ViewModel()

        viewModel.watchChanges(on: state)
        subscribeEvents()

        intialTableViewSetUp()
        intializeSearchBar()
        setUpActivityindicator()

        activityIndicatorView.startAnimating()
    }

    private func setUpActivityindicator() {
        activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                      y: 0,
                                                                      width: 50,
                                                                      height: 50))
        activityIndicatorView.backgroundColor = .white
        activityIndicatorView.style = UIActivityIndicatorView.Style.medium
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
    }

    private func intializeSearchBar() {
        DispatchQueue.main.async {
            self.navigationItem.searchController = self.searchController
            self.searchController.searchResultsUpdater = self
            self.navigationItem.hidesSearchBarWhenScrolling = false
            self.searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.searchBar.placeholder = "Movie Title"
            self.navigationItem.hidesSearchBarWhenScrolling = false
            self.definesPresentationContext = true
        }
    }

    private func intialTableViewSetUp() {
        let nib = UINib(nibName: "MovieDetailsTableViewCell", bundle: nil)
        movieListView.register(nib, forCellReuseIdentifier: "MovieDetailsTableViewCell")

        movieListView.delegate = self

        movieListView.estimatedRowHeight = UITableView.automaticDimension
        movieListView.rowHeight = 120.0
    }

    private func subscribeEvents() {
        viewModel.moviesCount
            .asObservable()
            .subscribe(onNext: { count in
                self.movieDetail.movieCount = count
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.movieListView.reloadData()
                }
        }).disposed(by: disposeBag)
    
        viewModel.movietitle
            .asObservable()
            .subscribe(onNext: { title in
                self.movieDetail.movieTitle = title
        }).disposed(by: disposeBag)
        
        viewModel.movieCategory
            .asObservable()
            .subscribe(onNext: { movieCategory in
                self.movieDetail.movieCategory = movieCategory
        }).disposed(by: disposeBag)
        
        viewModel.movieReleaseDate
            .asObservable()
            .subscribe(onNext: { movieReleaseDate in
                self.movieDetail.movieReleaseDate = movieReleaseDate
        }).disposed(by: disposeBag)
        
        viewModel.movieThumbnailImage
            .asObservable()
            .subscribe(onNext: { movieThumbnailImage in
                self.movieDetail.movieThumbnailImage = movieThumbnailImage
        }).disposed(by: disposeBag)
        
        viewModel.movieSummary
            .asObservable()
            .subscribe(onNext: { movieSummary in
                self.movieDetail.movieSummary = movieSummary
        }).disposed(by: disposeBag)
        
        viewModel.movieDetailImage
            .asObservable()
            .subscribe(onNext: { detailImage in
                self.movieDetail.detailImage = detailImage
        }).disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            self.movieListView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate -

extension MovieListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetail.movieCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell",
                                                       for: indexPath) as? MovieDetailsTableViewCell else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        state.getMovieDetails(of: indexPath.row)
        cell.customizeCell(with: movieDetail)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        state.getMovieDetails(of: indexPath.row)
        movieDetailController.movieDetails = movieDetail
        Utilites.logSplunkEvent(with: "Selected Movie Details")
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
}

//MARK: - UISearchResultsUpdating -

extension MovieListViewController {

    func updateSearchResults(for searchController: UISearchController) {
        state.searchMoviesList(with: searchController.searchBar.text!)
        Utilites.logSplunkEvent(with: "Search with Movie Title")
        DispatchQueue.main.async {
            self.movieListView.reloadData()
        }
    }
}
