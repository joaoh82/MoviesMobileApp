//
//  Constant.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/29/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import Foundation


struct Constants {
    //Constants related to the service URLs and End Points
    struct Service {
        let base_url : NSString = "https://api.themoviedb.org"
        let token : NSString = "1f54bd990f1cdfb230adb312546d765d"
        let discoverEndPoint : NSString = "/3/discover/movie"
        let genreEndPoint : NSString = "/3/genre/movie/list"
        let imageBaseUrl : NSString = "https://image.tmdb.org/t/p/w500"
        let sort_by : NSString = "primary_release_date.asc"
        let language : NSString = "en-US"
    }
    
    //Constants related to the name of the keys inside the JSON back from the API
    struct Data {
        struct Movie {
            let id : NSString = "id"
            let original_title : NSString = "original_title"
            let original_language : NSString = "original_language"
            let title : NSString = "title"
            let poster_path : NSString = "poster_path"
            let release_date : NSString = "release_date"
            let genre_ids : NSString = "genre_ids"
            let backdrop_path : NSString = "backdrop_path"
            let popularity : NSString = "overview"
            let vote_average : NSString = "vote_average"
            let overview : NSString = "overview"
        }
        
        struct Genre {
            let id : NSString = "id"
            let name : NSString = "name"
        }
    }
}
