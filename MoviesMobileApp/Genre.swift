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
        if let val = data["id"] {
            genreId=val as? Int
        }
        if data["name"] != nil {
            name=data["name"]! as? String
        }
    }
}
