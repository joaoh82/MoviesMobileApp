//
//  Movie.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
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
    
    init(data:[String:Any]) {
        if let val = data["id"] {
            movieId=val as? Int
        }
        if data["original_title"] != nil {
            originalTitle=data["original_title"]! as? String
        }
        if data["original_language"] != nil {
            originalLanguage=data["original_language"]! as? String
        }
        if data["title"] != nil {
            title=data["title"]! as? String
        }
        if data["poster_path"] != nil {
            posterPath=data["poster_path"]! as? String
        }
        if data["release_date"] != nil {
            releaseDate=data["release_date"]! as? String
        }
        if data["genre_ids"] != nil {
            genres=data["genre_ids"]! as? [Int]
        }
        if data["backdrop_path"] != nil {
            backdropPath=data["backdrop_path"]! as? String
        }
        if data["popularity"] != nil {
            popularity=data["popularity"]! as? Float
        }
        if data["vote_average"] != nil {
            voteAverage=data["vote_average"]! as? Float
        }
        if data["overview"] != nil {
            overview=data["overview"]! as? String
        }
    }
}
