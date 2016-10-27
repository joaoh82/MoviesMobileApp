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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating  {

    //MARK: IBOutlets
    @IBOutlet var moviesTableView:UITableView!
    
    var moviesArray = [Movie]()
    var filteredMoviesArray = [Movie]()
    
    var searchOn:Bool!
    let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredMoviesArray = moviesArray.filter { movie in
            return (movie.title?.lowercased().contains(searchText.lowercased()))!
        }
        self.moviesTableView.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController){
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = false
        searchController.searchBar.placeholder = "Search by name..."
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.setValue("Cancel", forKey:"_cancelButtonText")
        self.moviesTableView.tableHeaderView = searchController.searchBar
        
        self.getMovies(page: 1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        cell.textLabel?.text = movie.title
//        Alamofire.request(movie.posterPath!).responseImage { response in
//            if let image = response.result.value {
//                cell.posterImage.image = image
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.setSelected(false, animated: true)
    }


}

