//
//  MovieDetailViewController.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 Touch Surgery. All rights reserved.
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
    
    //MARK: Data
    var genresArray = [Genre]()
    var movie:Movie?

    //MARK: UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie?.title
        
        self.movieTitle.text = movie?.title
        // Crossing the genres_ids from the Movie with the Genre List pulled from theAPI earlier
        if movie?.genres != nil {
            var movieGenre = [Genre]()
            for item in (movie?.genres!)! {
                let filteredArray = genresArray.filter { genre in
                    return (genre.genreId == item)
                }
                movieGenre.append(contentsOf: filteredArray)
            }
            if movieGenre.count > 1 {
                var genres = ""
                for genre in movieGenre {
                    genres = genres + genre.name! + " | "
                }
                self.genre.text = String(genres.characters.dropLast(3))
            }else{
                self.genre.text = "Genre not specified"
            }
            
        }
        self.releaseDate.text = movie?.releaseDate
        
        // Using AlamofireImage to pull image asynchrony from the server
        if let path = movie?.posterPath {
            let url = URL(string: "\(Constants.Service().imageBaseUrl)\(path)")!
            let placeholderImage = UIImage(named: "placeholder")!
            self.posterImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
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
