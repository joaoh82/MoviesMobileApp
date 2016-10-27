//
//  ViewController.swift
//  MoviesMobileApp
//
//  Created by João Henrique Machado Silva on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import UIKit

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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UItableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMoviesArray.count
        }
        return moviesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesFoldingCell", for: indexPath as IndexPath) as! MoviesTableViewCell
        
        let movie:Movie
        
        if searchController.isActive && searchController.searchBar.text != "" {
            movie = filteredMoviesArray[indexPath.row]
        } else {
            movie = moviesArray[indexPath.row]
        }
        

//        cell.vehicleType.text = estimate.vehicleName
//        cell.vehicleTypeDescription.text = estimate.vehicleDescription
//        cell.priceFormatted.text = estimate.priceFormatted
//        Alamofire.request(estimate.vehicleIconUrl!).responseImage { response in
//            if let image = response.result.value {
//                cell.vehicleIcon.image = image
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.setSelected(false, animated: true)
    }


}

