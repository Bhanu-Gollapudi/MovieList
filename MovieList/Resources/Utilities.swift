//
//  Utilities.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 04/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation
import SplunkMint

struct Utilites {

    //MARK: - Fetch Image from URL -

    public static func getImageData(from imageString: String?) -> NSData? {
        guard
            let imageString = imageString,
            let url = URL(string: imageString),
            let data = NSData(contentsOf: url) else {
                return nil
        }
        return data
    }

    //MARK: - SplunkMint Event log -

    public static func logSplunkEvent(with eventName: String) {
        Mint.sharedInstance().logEvent(withName: eventName)
    }
}
