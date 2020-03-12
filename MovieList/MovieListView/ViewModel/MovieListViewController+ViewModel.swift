//
//  MovieListViewController+ViewModel.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 04/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation
import RxSwift

extension MovieListViewController {
    class ViewModel {
        var moviesCount = PublishSubject<Int>()
        var movietitle = PublishSubject<String?>()
        var movieCategory = PublishSubject<String?>()
        var movieReleaseDate =  PublishSubject<String?>()
        var movieThumbnailImage = PublishSubject<String?>()
        var movieSummary = PublishSubject<String?>()
        var movieDetailImage = PublishSubject<String?>()

        let disposeBag = DisposeBag()

        //MARK: -  Intialization

        init() {

        }

        func watchChanges(on state: State) {
            state.moviesListCount.subscribe(onNext: { count in
                self.moviesCount.onNext(count)
            }).disposed(by: disposeBag)

            state.movietitle.subscribe(onNext: { title in
                self.movietitle.onNext(title)
            }).disposed(by: disposeBag)

            state.movieCategory.subscribe(onNext: { category in
                self.movieCategory.onNext(category)
            }).disposed(by: disposeBag)

            state.movieReleaseDate.subscribe(onNext: { movieReleaseDate in
                self.movieReleaseDate.onNext(movieReleaseDate)
            }).disposed(by: disposeBag)

            state.movieThumbnailImage.subscribe(onNext: { movieThumbnailImage in
                self.movieThumbnailImage.onNext(movieThumbnailImage)
            }).disposed(by: disposeBag)

            state.movieSummary.subscribe(onNext: { movieSummary in
                self.movieSummary.onNext(movieSummary)
            }).disposed(by: disposeBag)

            state.movieDetailImage.subscribe(onNext: { movieDetailImage in
                self.movieDetailImage.onNext(movieDetailImage)
            }).disposed(by: disposeBag)
        }
    }
}
