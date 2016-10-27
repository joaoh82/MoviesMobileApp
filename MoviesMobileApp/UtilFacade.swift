//
//  UtilFacade.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import UIKit

class UtilFacade: NSObject {
    
    class var discoverEndPoint: String{
        get{
            return "/3/discover/movie"
        }
    }
    
    class var host: String{
        get{
            return "https://api.themoviedb.org"
        }
    }
    
    class var token: String{
        get{
            return "1f54bd990f1cdfb230adb312546d765d"
        }
    }

}
