//
//  MoviesMobileAppTests.swift
//  MoviesMobileAppTests
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 Touch Surgery. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
@testable import MoviesMobileApp

class MoviesMobileAppTests: XCTestCase {
    
    var service: UtilService!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        service = UtilService()
    }
    
    // Testing if Genre endpoint is return a list from the API
    func testSuccessGetGenres(){
        var resultArray = [Genre]()
        
        _ = service.getGenres()
            .subscribe(onNext: { n in
                    if let dict = n as? [String: AnyObject] {
                        if let twoDataArray = dict["genres"] as? Array<Dictionary<String, Any>>{
                            for data in twoDataArray{
                                let genre = Genre(data: data)
                                resultArray.append(genre)
                            }
                        }
                    }
                }
                , onError: {error in
                }
                , onCompleted: {
                    XCTAssertGreaterThanOrEqual(resultArray.count, 1)
                }, onDisposed: nil)
    }

    // Testing if Movies endpoint is return 20 items from a Random page
    func testSuccessGetMovies(){
        var resultArray = [Movie]()
        //Generate a random page number from 1 to 10
        let pageNum = arc4random_uniform(9)+1
        
        _ = service.getMovies(page: Int(pageNum))
            .subscribe(onNext: { n in
                    if let dict = n as? [String: AnyObject] {
                        if let twoDataArray = dict["results"] as? Array<Dictionary<String, Any>>{
                            for data in twoDataArray{
                                let movie = Movie(data: data)
                                resultArray.append(movie)
                            }
                        }
                    }
                }
                , onError: {error in
                }
                , onCompleted: {
                    XCTAssertGreaterThanOrEqual(resultArray.count, 20)
                }, onDisposed: nil)
    }
    
    override func tearDown() {
        super.tearDown()
        disposeBag = nil
    }
    
    //Test the perfomance of hte getMovies end point
    func testGetMoviesPerfomance() {
        var resultArray = [Movie]()
        self.measure {
            // Put the code you want to measure the time of here.
            let pageNum = arc4random_uniform(9)+1
            
            _ = self.service.getMovies(page: Int(pageNum))
                .subscribe(onNext: { n in
                    if let dict = n as? [String: AnyObject] {
                        if let twoDataArray = dict["results"] as? Array<Dictionary<String, Any>>{
                            for data in twoDataArray{
                                let movie = Movie(data: data)
                                resultArray.append(movie)
                            }
                        }
                    }
                    }
                    , onError: {error in
                    }
                    , onCompleted: {
                    }, onDisposed: nil)
        }
    }
    
}
