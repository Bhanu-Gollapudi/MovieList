//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 03/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MovieDetailsViewController: UIViewController {

    // MARK: -  IBOutlets -

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieCategory: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieSummary: UITextView!

    var movieDetails: MovieDetails?
    let disposeBag = DisposeBag()
    var viewModel: ViewModel!
    var state: State!

    // MARK: -  ViewLifeCycle -
    
    override func viewDidLoad() {
        Utilites.logSplunkEvent(with: "Movie Detail viewd")
        super.viewDidLoad()
        intialSetUp()
    }
}

// MARK: - Private methods -

extension MovieDetailsViewController {

    private func intialSetUp() {
        guard let movieDetails = self.movieDetails else { fatalError("Unable to get movie details") }

        state = State(movieDetails: movieDetails )
        viewModel = ViewModel()

        subscribeEvents()
        viewModel.watchChanges(on: state)
        state.updateMovieDetails()
    }

    private func subscribeEvents() {

        viewModel.movietitle
            .asObservable()
            .subscribe(onNext: { title in
                DispatchQueue.main.async {
                    self.movieTitleLabel.text = title
                }
            }).disposed(by: disposeBag)

        viewModel.movieCategory
            .asObservable()
            .subscribe(onNext: { category in
                DispatchQueue.main.async {
                    self.movieCategory.text = category
                }
            }).disposed(by: disposeBag)

        viewModel.movieReleaseDate
            .asObservable()
            .subscribe(onNext: { releaseDate in
                DispatchQueue.main.async {
                    self.movieReleaseDate.text = releaseDate
                }
            }).disposed(by: disposeBag)

        viewModel.movieSummary
            .asObservable()
            .subscribe(onNext: { category in
                DispatchQueue.main.async {
                    self.movieSummary.text = category
                }
            }).disposed(by: disposeBag)

        viewModel.movieDetailImage
            .asObservable()
            .subscribe(onNext: { detailImage in
                DispatchQueue.main.async {
                    self.loadDetailImage(from: detailImage)
                }
            }).disposed(by: disposeBag)
    }

    private func loadDetailImage(from imageString: String?) {
        guard let imageData = Utilites.getImageData(from: imageString) else {
            detailImageView.image = nil
            return
        }
        detailImageView.image = UIImage(data: imageData as Data)
    }
}
