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
    let totalPage: Int
    
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPage = "total_pages"
    }
}

struct Results: Decodable {
    
    let backdropPath: String?
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
   // let adult: Bool
    let genreIds: [Int]?
    let releaseDate: String?
    let average: Double?


    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case title
        case overview
        case posterPath = "poster_path"
       // case adult
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case average = "vote_average"
        
    }
}


// MARK: - GetImage API
struct GetImage: Decodable {
    
    let backdrops: [ImageInfo]
    let posters: [ImageInfo]
}

struct ImageInfo: Decodable {
    let height: Int
    let filePath: String
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case height
        case filePath = "file_path"
        case width

        
    }
}

// MARK: - Credit API
struct GetCredit: Decodable {
    
    let cast: [CastInfo]
}

struct CastInfo: Decodable {
    let name: String
    let profilePath: String?
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}



