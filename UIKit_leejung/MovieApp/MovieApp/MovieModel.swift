//
//  MovieModel.swift
//  MovieApp
//
//  Created by ohseungyeon on 8/23/24.
//

import Foundation

struct MovieModel: Codable{
    
    let resultCount: Int
    let results: [MovieResult]
}

struct MovieResult: Codable{
    let trackName: String
    let previewUrl: String
    let image: String
    let shortDescription: String?
    let longDescription: String
    let trackPrice: Double
    let currency: String
    let releaseDate: String
    
    //이름 똑같이 쓸거면 쓸필요 없다
    enum CodingKeys: String, CodingKey{
        case image = "artworkUrl100"
        case trackName
        case previewUrl
        case shortDescription
        case longDescription
        case trackPrice
        case currency
        case releaseDate
    }
}
