//
//  Genre.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import Foundation

struct Genre {
    var genreId:Int?
    var name:String?
    
    init(data:[String:Any]) {
        if let val = data[Constants.Data.Genre().id as String] {
            genreId=val as? Int
        }
        if data[Constants.Data.Genre().name as String] != nil {
            name=data[Constants.Data.Genre().name as String]! as? String
        }
    }
}
