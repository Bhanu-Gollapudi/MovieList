//
//  MovieDetailsTableViewCell.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 03/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsTableViewCell: UITableViewCell {

    // MARK: -  IBOutlets -

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!

    // MARK: - awakeFromNib -

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MovieDetailsTableViewCell {

    func customizeCell(with movieDetails: MovieDetails) {
        movieTitleLabel.text = movieDetails.movieTitle
        movieCategoryLabel.text = movieDetails.movieCategory
        movieReleaseDateLabel.text = movieDetails.movieReleaseDate
        loadThumbNailImage(from: movieDetails.movieThumbnailImage)
    }

    private func loadThumbNailImage(from imageString: String?) {
        guard let imageData = Utilites.getImageData(from: imageString) else {
            detailImageView.image = nil
            return
        }
        detailImageView.image = UIImage(data: imageData as Data)
    }
}
