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
    case getImage(id: Int)
    case getCredit(id: Int, language: String = Configuration.Language.korean.rawValue)
    
    var baseURL: String {
        "https://api.themoviedb.org/3/"
    }
    
//    var secureImageURL: String {
//        return Configuration.shared.secureURL
//    }
    
    var endPoint: URL {
        switch self {
        case.trending:
            return URL(string: baseURL + "trending/movie/day")!
        case .getImage(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        case let .getCredit(id, _):
            return URL(string: baseURL + "movie/\(id)/credits")!
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
        case .getImage:
            return nil
        case let .getCredit(_, language):
            let parameters = ["language": language]
            return parameters
        }
        
    }
}

class NetworkManger {
    
    static let shared = NetworkManger()
    
    private init() { }
    
    func callRequest<T: Decodable>(api: TMDBRequest, type: T.Type, completionHandler: @escaping (T) -> Void, failHandler: @escaping () -> Void) {
        
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString),headers: api.header).responseString { value in
            //print(api)
           // dump(value)
        }
        
        
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: (T.self)) { response in
            
            switch response.result {
            case .success(let value):
               // dump(value)
                completionHandler(value)
            case .failure(let error):
                //dump(error)
                failHandler()
                
            }
        }
    }
    
}
