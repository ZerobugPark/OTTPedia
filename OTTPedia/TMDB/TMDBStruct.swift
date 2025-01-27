//
//  TMDㅠStruct.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/27/25.
//

import Foundation



// MARK: - Trending API
struct Trending: Decodable {
    
    let results: [Results]
}

struct Results: Decodable {
    
    let backdropPath: String
    let title: String
    let overview: String
    let posterPath: String
    let adult: Bool
    let genreIds: [Int]
    let releaseDate: String
    let average: Double
    
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case title
        case overview
        case posterPath = "poster_path"
        case adult
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case average = "vote_average"
        
    }
}









