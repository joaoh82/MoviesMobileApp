//
//  ViewController.swift
//  MoviesMobileApp
//
//  Created by Avenue Code on 10/27/16.
//  Copyright © 2016 ArcTouch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //MARK: IBOutlets
    @IBOutlet var moviesTableView:UITableView!
    
    var moviesArray = [String]()
    var filteredMoviesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UItableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesFoldingCell", for: indexPath as IndexPath) as! MoviesTableViewCell
        
//        let estimate:Estimate = Estimate.init(data: json!.object(at: indexPath.row) as! [String:Any])
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

