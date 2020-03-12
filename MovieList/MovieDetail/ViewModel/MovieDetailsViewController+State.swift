//
//  MovieDetailsViewController+State.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 05/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation
import RxSwift

extension MovieDetailsViewController {
    class State {
        var movietitle = PublishSubject<String?>()
        var movieCategory = PublishSubject<String?>()
        var movieReleaseDate =  PublishSubject<String?>()
        var movieSummary = PublishSubject<String?>()
        var movieDetailImage = PublishSubject<String?>()
        let movieDetails: MovieDetails

        //MARK: -  Intialization

        init(movieDetails: MovieDetails) {
            self.movieDetails = movieDetails
            movietitle.onNext(nil)
            movieCategory.onNext(nil)
            movieReleaseDate.onNext(nil)
            movieSummary.onNext(nil)
            movieDetailImage.onNext(movieDetails.detailImage)
        }

        func updateMovieDetails() {
            movietitle.onNext(movieDetails.movieTitle)
            movieCategory.onNext(movieDetails.movieCategory)
            movieReleaseDate.onNext(movieDetails.movieReleaseDate)
            movieSummary.onNext(movieDetails.movieSummary)
            movieDetailImage.onNext(movieDetails.detailImage)
        }
    }
}
