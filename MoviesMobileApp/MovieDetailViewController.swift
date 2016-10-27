//
//  MovieDetailViewController.swift
//  MoviesMobileApp
//
//  Created by Avenue Code on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var genresArray = [Genre]()
    var movie:Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.movieTitle.text = movie?.title
        if movie?.genres != nil {
            var movieGenre = [Genre]()
            for item in (movie?.genres!)! {
                let filteredArray = genresArray.filter { genre in
                    return (genre.genreId == item)
                }
                movieGenre.append(contentsOf: filteredArray)
            }
            var genres = ""
            for genre in movieGenre {
                genres = genres + " " + genre.name! + " "
            }
            self.genre.text = genres
            
        }
        self.releaseDate.text = movie?.releaseDate
        if (movie?.posterPath != nil) {
            Alamofire.request(UtilFacade.imageBaseUrl+(movie?.posterPath!)!).responseImage { response in
                if let image = response.result.value {
                    self.posterImage.image = image
                }
            }
        }
        self.overview.text = movie?.overview

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
