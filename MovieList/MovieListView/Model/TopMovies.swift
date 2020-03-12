//
//  TopMovies.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 03/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import Foundation

// MARK: - Welcome

struct TopMovies: Codable {
    let feed: Feed
}

// MARK: - Feed

struct Feed: Codable {
    let author: Author
    let entry: [Entry]
    let updated, rights, title, icon: Icon
    let link: [FeedLink]
    let id: Icon
}

// MARK: - Author

struct Author: Codable {
    let name, uri: Icon
}

// MARK: - Icon

struct Icon: Codable {
    let label: String
}

// MARK: - Entry

struct Entry: Codable {
    let imName: Icon
    let rights: Icon?
    let imImage: [IMImage]
    let summary: Icon
    let imRentalPrice: IMPrice?
    let imPrice: IMPrice
    let imContentType: IMContentType
    let title: Icon
    let link: [EntryLink]
    let id: ID
    let imArtist: Icon
    let category: Category
    let imReleaseDate: IMReleaseDate

    enum CodingKeys: String, CodingKey {
        case imName = "im:name"
        case rights
        case imImage = "im:image"
        case summary
        case imRentalPrice = "im:rentalPrice"
        case imPrice = "im:price"
        case imContentType = "im:contentType"
        case title, id, link
        case imArtist = "im:artist"
        case category
        case imReleaseDate = "im:releaseDate"
    }
}

// MARK: - Category

struct Category: Codable {
    let attributes: CategoryAttributes
}

// MARK: - CategoryAttributes

struct CategoryAttributes: Codable {
    let imID, term: String
    let scheme: String
    let label: String

    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
        case term, scheme, label
    }
}

// MARK: - ID

struct ID: Codable {
    let label: String
    let attributes: IDAttributes
}

// MARK: - IDAttributes

struct IDAttributes: Codable {
    let imID: String

    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
    }
}

// MARK: - IMContentType

struct IMContentType: Codable {
    let attributes: IMContentTypeAttributes
}

// MARK: - IMContentTypeAttributes

struct IMContentTypeAttributes: Codable {
    let term, label: ContentType
}

// MARK: - IMImage

struct IMImage: Codable {
    let label: String
    let attributes: IMImageAttributes
}

// MARK: - IMImageAttributes

struct IMImageAttributes: Codable {
    let height: String
}

// MARK: - IMPrice

struct IMPrice: Codable {
    let label: String
    let attributes: IMPriceAttributes
}

// MARK: - IMPriceAttributes

struct IMPriceAttributes: Codable {
    let amount: String
    let currency: Currency
}

// MARK: - IMReleaseDate

struct IMReleaseDate: Codable {
    let label: String
    let attributes: Icon
}

// MARK: - EntryLink

struct EntryLink: Codable {
    let attributes: PurpleAttributes
    let imDuration: Icon?

    enum CodingKeys: String, CodingKey {
        case attributes
        case imDuration = "im:duration"
    }
}

// MARK: - PurpleAttributes

struct PurpleAttributes: Codable {
    let rel: Rel
    let type: TypeEnum
    let href: String
    let title: String?
    let imAssetType: IMAssetType?

    enum CodingKeys: String, CodingKey {
        case rel, type, href
        case imAssetType = "im:assetType"
        case title = "Preview"
    }
}

// MARK: - FeedLink

struct FeedLink: Codable {
    let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes

struct FluffyAttributes: Codable {
    let rel: String
    let type: TypeEnum?
    let href: String
}

// MARK: - IMAssetType

enum IMAssetType: String, Codable {
    case preview = "preview"
}

 //MARK: - Rel

enum Rel: String, Codable {
    case alternate = "alternate"
    case enclosure = "enclosure"
}

// MARK: - TypeEnum

enum TypeEnum: String, Codable {
    case textHTML = "text/html"
    case videoXM4V = "video/x-m4v"
}

// MARK: - Currency

enum Currency: String, Codable {
    case usd = "USD"
}

// MARK: - ContentType

enum ContentType: String, Codable {
    case movie = "Movie"
}
