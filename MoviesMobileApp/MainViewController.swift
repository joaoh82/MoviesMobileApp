//
//  ViewController.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import AlamofireImage

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating  {

    //MARK: IBOutlets
    @IBOutlet var moviesTableView:UITableView!
    var refreshControl = UIRefreshControl()
    
    //MARK: Data
    var moviesArray = [Movie]()
    var filteredMoviesArray = [Movie]()
    var genresArray = [Genre]()
    var selectedMovie:Movie?
    var nextPage:Int = 1
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: UISearchController Methods
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredMoviesArray = moviesArray.filter { movie in
            return (movie.title?.lowercased().contains(searchText.lowercased()))!
        }
        self.moviesTableView.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController){
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    //MARK: UIViewController Methods
    
    override func viewWillAppear(_ animated: Bool) {
        self.getGenres()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Upcoming movies"
        
        //Set up SearchController
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = false
        searchController.searchBar.placeholder = "Search by name..."
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.setValue("Cancel", forKey:"_cancelButtonText")
        self.moviesTableView.tableHeaderView = searchController.searchBar
        
        //Set up the RefreshControl
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControlEvents.valueChanged)
        self.moviesTableView?.addSubview(refreshControl)
        
        self.getMovies(page: self.nextPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Service Methods
    
    func refresh(sender:AnyObject) {
        if self.moviesArray.count < 51{
            self.getMovies(page: self.nextPage)
        }else{
            if self.refreshControl.isRefreshing
            {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func getGenres(){
        self.genresArray.removeAll()
        let service = UtilService()
        _ = service.getGenres()
            .subscribe(onNext: { n in
                print("next")
                if let dict = n as? [String: AnyObject] {
                    if let twoDataArray = dict["genres"] as? Array<Dictionary<String, Any>>{
                        for data in twoDataArray{
                            let genre = Genre(data: data)
                            self.genresArray.append(genre)
                        }
                    }
                }
                }
                , onError: {error in
                    print(error)
                }
                , onCompleted: {
                    print("Completed")
                    self.moviesTableView.reloadData()
                }
                , onDisposed: {
                    print("Disposed")
                }
        )
    }
    
    func getMovies(page:Int){
        let service = UtilService()
        _ = service.getMovies(page: 1)
            .subscribe(onNext: { n in
                print("next")
                    if let dict = n as? [String: AnyObject] {
                        if let twoDataArray = dict["results"] as? Array<Dictionary<String, Any>>{
                            for data in twoDataArray{
                                let movie = Movie(data: data)
                                self.moviesArray.append(movie)
                            }
                        }
                    }
                }
                , onError: {error in
                    print(error)
                }
                , onCompleted: {
                    print("Completed")
                    if self.refreshControl.isRefreshing
                    {
                        self.refreshControl.endRefreshing()
                    }
                    self.nextPage += 1
                    self.moviesTableView.reloadData()
                }
                , onDisposed: {
                    print("Disposed")
                }
        )
    }

    // MARK: UItableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMoviesArray.count
        }
        return moviesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath as IndexPath) as! MoviesTableViewCell
        
        var movie:Movie
        if searchController.isActive && searchController.searchBar.text != "" {
            movie = filteredMoviesArray[indexPath.row]
        } else {
            movie = moviesArray[indexPath.row]
        }
        cell.title.text = movie.title
        
        // Crossing the genres_ids from the Movie with the Genre List pulled from theAPI earlier
        if movie.genres != nil {
            var movieGenre = [Genre]()
            for item in movie.genres! {
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
                cell.genre.text = String(genres.characters.dropLast(3))
            }else{
                cell.genre.text = "Genre not specified."
            }
        }

        cell.releaseDate.text = movie.releaseDate
        // Using AlamofireImage to pull image asynchrony from the server
        if (movie.posterPath != nil) {
            let url = URL(string: "\(Constants.Service().imageBaseUrl)\(movie.posterPath!)")!
            let placeholderImage = UIImage(named: "placeholder")!
            cell.posterImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.setSelected(false, animated: true)
        
        if searchController.isActive && searchController.searchBar.text != "" {
            self.selectedMovie = filteredMoviesArray[indexPath.row]
        } else {
            self.selectedMovie = moviesArray[indexPath.row]
        }
        searchController.isActive = false
        self.performSegue(withIdentifier: "showMovieDetail", sender: self)
    }


    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let movieDetailViewController = segue.destination as? MovieDetailViewController{
                movieDetailViewController.movie = self.selectedMovie
                movieDetailViewController.genresArray = self.genresArray
            } else {
                print("Data NOT Passed! destination vc is not set to firstVC")
            }
        } else { print("Id doesnt match with Storyboard segue Id") }

     }
 

}

