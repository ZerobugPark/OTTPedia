//
//  TMDBError.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/31/25.
//

import UIKit

enum TMDBError: Int, Error {
    case verificationFailed = 400
    case authenticationFailed = 401
    case accountSuspension = 403
    case invalidRequest = 404
    case wrongForm = 405
    case invalidHeader = 406
    case invalidParameter = 422
    case limitExceeded = 429
    case tmdbError = 500
    case noService = 501
    case backendConnectionError = 502
    case offline = 503
    case timeout = 504
    
}

struct ApiError {
    
    static let shared = ApiError()
    private init() { }
    
    func apiError(status: Int) throws {
        switch status {
        case 400:
            throw TMDBError.verificationFailed
        case 401:
            throw TMDBError.authenticationFailed
        case 403:
            throw TMDBError.accountSuspension
        case 404:
            throw TMDBError.invalidRequest
        case 405:
            throw TMDBError.wrongForm
        case 406:
            throw TMDBError.invalidHeader
        case 422:
            throw TMDBError.invalidParameter
        case 429:
            throw TMDBError.limitExceeded
        case 500:
            throw TMDBError.tmdbError
        case 501:
            throw TMDBError.noService
        case 502:
            throw TMDBError.backendConnectionError
        case 503:
            throw TMDBError.offline
        case 504:
            throw TMDBError.timeout
        default:
            break
           
        }
    }
    
    func apiErrorDoCatch(apiStatus: Int) -> String {
    
        do {
            try apiError(status: apiStatus)
        } catch TMDBError.verificationFailed {
            return "검증실패"
        } catch TMDBError.authenticationFailed {
           return "인증실패"
        } catch TMDBError.accountSuspension {
            return "계정정지"
        } catch TMDBError.invalidRequest {
            return "잘못된 요청"
        } catch TMDBError.wrongForm {
            return "잘못된 형식"
        } catch TMDBError.invalidHeader  {
            return "잘못된 수락 헤더"
        } catch TMDBError.invalidParameter {
            return "잘못된 파라미터"
        } catch TMDBError.limitExceeded {
            return "요청한도 초과"
        } catch  TMDBError.tmdbError {
            return "TMDB 오류"
        } catch TMDBError.noService {
            return "잘못된 서비스"
        } catch TMDBError.backendConnectionError {
            return "백엔드 연결 실패"
        } catch  TMDBError.offline {
            return "서비스 오프라인"
        } catch TMDBError.timeout {
            return "시간초과"
        } catch  {
            return "Unknown"
        }

        return "Unknown"
    }
    
    
}

// MARK: - Extension UIViewController
extension UIViewController {
    func showAPIAlet(msg: String) {
        let title = "API 오류"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}




    
