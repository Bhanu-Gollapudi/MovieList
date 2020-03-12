//
//  MovieListViewController+State.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 04/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation
import RxSwift

extension MovieListViewController {
    class State {
        private var moviesList: [Entry] = []
        private var filteredList: [Entry] = []

        var movietitle = PublishSubject<String?>()
        var movieCategory = PublishSubject<String?>()
        var movieReleaseDate =  PublishSubject<String?>()
        var movieThumbnailImage = PublishSubject<String?>()
        var movieSummary = PublishSubject<String?>()
        var movieDetailImage = PublishSubject<String?>()
        var moviesListCount = PublishSubject<Int>()
        var topMoviesEntries = PublishSubject<[Entry]>()

        //MARK: -  Intialization

        init() {
            fetchMoviesList()
        }

        public func getMovieDetails(of index: Int) {
            let movieEntry = filteredList[index]
            movietitle.onNext(movieEntry.title.label)
            movieCategory.onNext(movieEntry.category.attributes.term)
            movieReleaseDate.onNext(movieEntry.imReleaseDate.attributes.label)
            movieThumbnailImage.onNext(movieEntry.imImage[0].label)
            movieSummary.onNext(movieEntry.summary.label)
            movieDetailImage.onNext(movieEntry.imImage[2].label)
        }

        public func searchMoviesList(with text: String) {
            filteredList = moviesList.filter({ (movie) -> Bool in
                return movie.title.label.contains(text)
            })

            guard text.isEmpty else {
                topMoviesEntries.onNext(filteredList)
                moviesListCount.onNext(filteredList.count)
                return
            }
            topMoviesEntries.onNext(moviesList)
            moviesListCount.onNext(moviesList.count)
            filteredList = moviesList
        }

        // MARK: - Private methods

        private func fetchMoviesList() {
            Utilites.logSplunkEvent(with: "Service call to fetch movies list")
            MovieAPIClinet.shared.getMovieList { (response, status) in
                Utilites.logSplunkEvent(with: "Fetched Movies list")
                if let entriesList = response as? [Entry] {
                    self.topMoviesEntries.onNext(entriesList)
                    self.moviesListCount.onNext(entriesList.count)
                    self.moviesList = entriesList
                    self.filteredList = entriesList
                }
            }
        }
    }
}
