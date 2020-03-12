//
//  APIClient.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 03/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation

typealias completionHanlder = (_ response: Any, _ status: Bool) -> Void

private enum HttpCodeType: String {
    case get = "GET"
}

private var baseURL: String = {
    return "https://itunes.apple.com/"
}()

private enum path: String {
    case topMoviesList

    func getPath() -> String {
        switch self {
        case .topMoviesList:
            return baseURL + "us/rss/topmovies/limit=50/json"
        }
    }
}

struct MovieAPIClinet {

    // MARK: Intialization -

    private init(){}

    // MARK: - Constants -
    static let shared = MovieAPIClinet()
    
    // MARK: - GetMovieList -

    func getMovieList(handler: @escaping completionHanlder) {
        let headers = [
            "content-type": "application/json",
            "accept": "application/json",
        ]

        guard let URL = URL(string: path.topMoviesList.getPath()) else { return  }

        var request = URLRequest(url: URL)
        request.allHTTPHeaderFields = headers
        request.httpMethod = HttpCodeType.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                handler("", false)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                handler("", false)
                return
            }

            do {
                if let responseDictionary: [String : Any] = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseDictionary, options: .prettyPrinted)
                        let report = try JSONDecoder().decode(TopMovies.self, from: jsonData)
                        handler(report.feed.entry, true)
                    }
                    catch {
                        handler(error, false)
                    }
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
}
