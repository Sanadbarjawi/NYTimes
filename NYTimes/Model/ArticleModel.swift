//
//  ArticleModel.swift
//  NYTimes
//
//  Created by Sanad Barjawi on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import Foundation

struct ArticleModel: Networkable {
    let status, copyright: String
    let numResults: Int
    let results: [ArticleItem]
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - ArticleItem
struct ArticleItem: Networkable {
    let url: String
    let adxKeywords: String
    let column: String?
    let section, byline: String
    let type: ResultType
    let title, abstract, publishedDate: String
    let source: Source
    let id, assetID, views: Int
    let media: [Media]
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case adxKeywords = "adx_keywords"
        case column, section, byline, type, title, abstract
        case publishedDate = "published_date"
        case source, id
        case assetID = "asset_id"
        case views
        case media, uri
    }
}

// MARK: - Media
struct Media: Networkable {
    let type: MediaType
    let subtype: Subtype
    let caption, copyright: String?
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]
    
    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Networkable {
    let url: String
    let format: Format
    let height, width: Int
}

enum Format: String, Networkable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

enum Subtype: String, Networkable {
    case photo = "photo"
}

enum MediaType: String, Networkable {
    case image = "image"
}

enum Source: String, Networkable {
    case theNewYorkTimes = "The New York Times"
}

enum ResultType: String, Networkable {
    case article = "Article"
    case interactive = "Interactive"
}

