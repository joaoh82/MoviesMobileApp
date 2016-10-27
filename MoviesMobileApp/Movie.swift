//
//  Movie.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import Foundation

struct Movie {
    var movieId:String?
    var originalTitle:String?
    var originalLanguage:String?
    var title:String?
    var posterPath:String?
    var releaseDate:String?
    var genres:[Int]?
    var overview:String?
    
    init(data:[String:Any]) {
        if let val = data["id"] {
            movieId=val as? String
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
        if data["genres"] != nil {
            genres=data["genres"]! as? [Int]
        }
        if data["overview"] != nil {
            overview=data["overview"]! as? String
        }
    }
}
