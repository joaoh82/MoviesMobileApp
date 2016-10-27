//
//  UtilService.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class UtilService: NSObject {

    // Goes to the API and returns 20 movies for every request. 20 is size of the page seted by the API.
    func getMovies(page:Int) -> Observable<AnyObject?> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = NSDate()
        let url = "\(UtilFacade.host+UtilFacade.discoverEndPoint)?api_key=\(UtilFacade.token)&language=en-US&sort_by=primary_release_date.asc&include_video=true&page=\(page)&primary_release_date.gte=\(dateFormatter.string(from: currentDate as Date))"
        
        return Observable.create { observer in
            var request = URLRequest(url: NSURL(string: url) as! URL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            Alamofire.request(request).responseJSON { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
                
                observer.on(.next(response.result.value as AnyObject!))
                observer.on(.completed)
                
                let statusCode = response.response?.statusCode
                if let error = response.result.error as? AFError {
                    var statusCode = error._code // statusCode private
                    switch error {
                    case .invalidURL(let url):
                        print("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        print("Parameter encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        print("Multipart encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            print("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                            statusCode = code
                        }
                    case .responseSerializationFailed(let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    }
                    print("Underlying error: \(error.underlyingError)")
                } else if let error = response.result.error as? URLError {
                    print("URLError occurred: \(error)")
                    observer.on(.error(response.result.error!))
                } else {
                    print("Unknown error: \(response.result.error)")
                }
                print("STATUS CODE: \(statusCode)") // the status code
            }
            return Disposables.create()
        }
    }
    
    
    // Goes to the API and brings an updated list of all Genres
    func getGenres() -> Observable<AnyObject?> {
        let url = "\(UtilFacade.host+UtilFacade.genresEndPoint)?api_key=\(UtilFacade.token)&language=en-US"
        
        return Observable.create { observer in
            var request = URLRequest(url: NSURL(string: url) as! URL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            Alamofire.request(request).responseJSON { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
                
                observer.on(.next(response.result.value as AnyObject!))
                observer.on(.completed)
                
                let statusCode = response.response?.statusCode
                if let error = response.result.error as? AFError {
                    var statusCode = error._code // statusCode private
                    switch error {
                    case .invalidURL(let url):
                        print("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        print("Parameter encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        print("Multipart encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            print("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                            statusCode = code
                        }
                    case .responseSerializationFailed(let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    }
                    print("Underlying error: \(error.underlyingError)")
                } else if let error = response.result.error as? URLError {
                    print("URLError occurred: \(error)")
                    observer.on(.error(response.result.error!))
                } else {
                    print("Unknown error: \(response.result.error)")
                }
                print("STATUS CODE: \(statusCode)") // the status code
            }
            return Disposables.create()
        }
    }
    
}
