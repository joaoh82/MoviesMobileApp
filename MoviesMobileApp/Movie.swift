//
//  Movie.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 Touch Surgery. All rights reserved.
//

import Foundation

struct Movie {
    var movieId:Int?
    var originalTitle:String?
    var originalLanguage:String?
    var title:String?
    var posterPath:String?
    var backdropPath:String?
    var popularity:Float?
    var voteAverage:Float?
    var releaseDate:String?
    var genres:[Int]?
    var overview:String?
    
    //Instantiates the object with the Dictionary returned from the service
    init(data:[String:Any]) {
        if let val = data[Constants.Data.Movie().id as String] {
            movieId=val as? Int
        }
        if data[Constants.Data.Movie().original_title as String] != nil {
            originalTitle=data[Constants.Data.Movie().original_title as String]! as? String
        }
        if data[Constants.Data.Movie().original_language as String] != nil {
            originalLanguage=data[Constants.Data.Movie().original_language as String]! as? String
        }
        if data[Constants.Data.Movie().title as String] != nil {
            title=data[Constants.Data.Movie().title as String]! as? String
        }
        if data[Constants.Data.Movie().poster_path as String] != nil {
            posterPath=data[Constants.Data.Movie().poster_path as String]! as? String
        }
        if data[Constants.Data.Movie().release_date as String] != nil {
            releaseDate=data[Constants.Data.Movie().release_date as String]! as? String
        }
        if data[Constants.Data.Movie().genre_ids as String] != nil {
            genres=data[Constants.Data.Movie().genre_ids as String]! as? [Int]
        }
        if data[Constants.Data.Movie().backdrop_path as String] != nil {
            backdropPath=data[Constants.Data.Movie().backdrop_path as String]! as? String
        }
        if data[Constants.Data.Movie().popularity as String] != nil {
            popularity=data[Constants.Data.Movie().popularity as String]! as? Float
        }
        if data[Constants.Data.Movie().vote_average as String] != nil {
            voteAverage=data[Constants.Data.Movie().vote_average as String]! as? Float
        }
        if data[Constants.Data.Movie().overview as String] != nil {
            overview=data[Constants.Data.Movie().overview as String]! as? String
        }
    }
}
