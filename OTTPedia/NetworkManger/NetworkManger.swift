//
//  NetworkManger.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/27/25.
//

import Foundation

import Alamofire

enum TMDBRequest {
    
    
    case trending(language: String = Configuration.Language.korean.rawValue)
    
    var baseURL: String {
        "https://api.themoviedb.org/3/trending/movie/"
    }
    
//    var secureImageURL: String {
//        return Configuration.shared.secureURL
//    }
    
    var endPoint: URL {
        switch self {
        case.trending:
            return URL(string: baseURL + "day")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Bearer \(TMDBAPI.client_ID)"]
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters? {
        switch self {
        case .trending(let language):
            let parameters = ["language": language]
            return parameters
        }
    }
}

class NetworkManger {
    
    static let shared = NetworkManger()
    
    private init() { }
    
    func callRequest<T: Decodable>(api: TMDBRequest, type: T.Type, completionHandler: @escaping (T) -> Void, failHandler: @escaping () -> Void) {
        
//        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString),headers: api.header).responseString { value in
//            dump(value)
//        }
        
        
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: (T.self)) { response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                failHandler()
            }
        }
    }
    
}
