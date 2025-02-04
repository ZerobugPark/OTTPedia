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
    case searchMoive(query: String, adult: Bool = false, language: String = Configuration.Language.korean.rawValue, page: Int)
    
    var baseURL: String {
        "https://api.themoviedb.org/3/"
    }
    
    
    var endPoint: URL {
        switch self {
        case.trending:
            return URL(string: baseURL + "trending/movie/day")!
        case .getImage(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        case let .getCredit(id, _):
            return URL(string: baseURL + "movie/\(id)/credits")!
        case .searchMoive:
            return URL(string: baseURL + "search/movie")!
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
        case let .searchMoive(query, adult, language, page):
            let parameters = ["query": query ,"include_adult": String(adult), "language": language, "page": String(page)]
            return parameters
        }
        
    }
}

class NetworkManger {
    
    static let shared = NetworkManger()
    
    private init() { }
    
//    func callRequest<T: Decodable>(api: TMDBRequest, type: T.Type, completionHandler: @escaping (T) -> Void, failHandler: @escaping (Int) -> Void) {
//        
//  
//        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: (T.self)) { response in
//            
//            switch response.result {
//            case .success(let value):
//                //dump(value)
//                completionHandler(value)
//            case .failure(let error):
//                if let status = response.response?.statusCode {
//                    failHandler(status)
//                 // 어떻게 하면 status에 statusCode를 추가해볼 수 있을까?
//                }
//                dump(error)
//                
//                
//            }
//        }
//    }
//    

    func callRequest<T: Decodable>(api: TMDBRequest, type: T.Type, completionHandler: @escaping (Result <(T), AFError>) -> Void) {
        
  
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: (T.self)) { response in
            
            switch response.result {
            case .success(let value):
                //dump(value)
                completionHandler(.success(value))
            case .failure(let error):
                //dump(error)
                completionHandler(.failure(error))
                
                
                
            }
        }
    }
    
}
