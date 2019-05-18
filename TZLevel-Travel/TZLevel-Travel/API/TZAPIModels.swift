//
//  TZAPIModels.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 08.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit
import Foundation

struct TZAPIModels: Decodable {
    let resultsCount: Int
}

// MARK: - iTunes

struct iTunesObject: Decodable {
    let artistId: Int?
    let artistName: String?
    let artistViewUrl: String?
    let artworkUrl100: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let collectionArtistId: Int?
    let collectionArtistName: String?
    let collectionCensoredName: String?
    let collectionExplicitness: String?
    let collectionId: Int?
    let collectionName: String?
    let collectionPrice: Float?
    let collectionViewUrl: String?
    let country: String?
    let currency: String?
    let discCount: Int?
    let discNumber: Int?
    let isStreamable: Bool?
    let kind: String?
    let previewUrl: String?
    let primaryGenreName: String?
    let releaseDate: String?
    let trackCensoredName: String?
    let trackCount: Int?
    let trackExplicitness: String?
    let trackId: Int?
    let trackName: String?
    let trackNumber: Int?
    let trackPrice: Float?
    let trackTimeMillis: Int?
    let trackViewUrl: String?
    let wrapperType: String?
}

struct TZiTunesData: Decodable {
    let resultCount: Int?
    let results: [iTunesObject]?
}

// MARK: - Last.fm

struct LastFMImages: Decodable {
    private enum CodingKeys : String, CodingKey {
        case text = "#text"
        case size = "size"
    }
    let text: String?
    let size: String?
}

struct LastFMTrack: Decodable {
    let artist: String?
    let image: [LastFMImages]?
    let listeners: String?
    let mbid: String?
    let name: String?
    let streamable: String?
    let url: String?
}

struct LastFMTracks: Decodable {
    let track: [LastFMTrack]
}

struct LastFMAttr: Decodable {
    
}

struct LastFMQuery: Decodable {
    private enum CodingKeys : String, CodingKey {
        case text = "#text"
        case role = "role"
        case startPage = "startPage"
    }
    
    let text: String?
    let role: String?
    let startPage: String?
}

struct LastFMResults: Decodable {
//    let trackmatches: [LastFMTracks]?
    
    private enum CodingKeys : String, CodingKey {
        case attr = "@attr"
        case query = "opensearch:Query"
        case itemsPerPage = "opensearch:itemsPerPage"
        case startIndex = "opensearch:startIndex"
        case totalResults = "opensearch:totalResults"
        case trackmatches = "trackmatches"
    }
    
    let attr: LastFMAttr?
    let query: LastFMQuery?
    let itemsPerPage: String?
    let startIndex: String?
    let totalResults: String?
    let trackmatches: LastFMTracks?
}

struct TZLastFMData: Decodable {
    private enum CodingKeys : String, CodingKey { case results = "results" }
    let results : LastFMResults?
}
