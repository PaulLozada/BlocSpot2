//
//  ViewController.swift
//  BlocSpot 2
//
//  Created by Paul Lozada on 2015-06-11.
//  Copyright © 2015 Paul Lozada. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource {
    
    
    
    var array : [MKMapItem!] = []
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Search Results"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if(indexPath.section == 0){
            
            for item in self.array {

                cell.textLabel?.text =  self.array[indexPath.row].name
                cell.detailTextLabel?.text = self.array[indexPath.row].phoneNumber
                
                print(item)
            }
            
        } else {
            cell.detailTextLabel?.text = "Paul Lozada"
        }
        
        return cell
        
    }
    
    //MARK: Temporary Storage
    
    //Will implement CoreData as permanent data persistence in the future
    
    var searchResult : String? = nil
    let searchRequest = MKLocalSearchRequest()
    var persistedResults = [String]()
    var callBack = [String]()
    
    @IBOutlet var tableView: UITableView!
    
    
    //MARK: UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        tableView.hidden = false
    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        print("Bookmark button pressed")
        tableView.reloadData()
    }
   
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        tableView.hidden = true
        searchBar.endEditing(true)

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let localSearch = MKLocalSearch(request: searchRequest)
//        let latitude : CLLocationDegrees = 50.0
        
//        let longitude : CLLocationDegrees =  40.0
        
        let mapRectange = MKMapRectMake(400, 400, 400, 400)
        searchRequest.region = MKCoordinateRegionForMapRect(mapRectange)
        searchRequest.naturalLanguageQuery = searchResult
        
        
        persistedResults.append(searchRequest.naturalLanguageQuery!)
        
        print(persistedResults)
        
        localSearch.startWithCompletionHandler { (response, error) -> Void in

            
            if response != nil{
                
                    self.array = (response?.mapItems)!
                
              
                
                   self.tableView.reloadData()
                
                print(self.array)
                
            } else{
                
                let alert = UIAlertController(title: "No Results Found", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okay = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                
                alert.addAction(okay)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
        searchResult = searchText
    }
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet var mainMapView: MKMapView!
  
    
    
    @IBAction func pressedSegmentedControl(sender: UISegmentedControl) {
        
        
    // Change with switch statement soon
        
        
        if segmented.selectedSegmentIndex == 0 {
        mainMapView.mapType = MKMapType.Standard
        }
        
        if segmented.selectedSegmentIndex == 1 {
            mainMapView.mapType = MKMapType.Satellite
        }
        
        if segmented.selectedSegmentIndex == 2 {
            mainMapView.mapType = MKMapType.Hybrid
        }
        
        
        print(segmented.selectedSegmentIndex)
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // SearchBar
        segmented.tintColor = UIColor(red: 0.175, green: 0.727, blue: 0.831, alpha: 1)
        searchBar.placeholder = "Type Search here"
        searchBar.prompt = "BlocSpot"
        searchBar.tintColor = UIColor(red: 0.175, green: 0.727, blue: 0.831, alpha: 1)
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        searchBar.showsCancelButton = true
        searchBar.translucent = true
        searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        // MapRegion
        let latitude : CLLocationDegrees = 50.999150
        let longitude : CLLocationDegrees = -114.072579
        let centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let latitudinalMeters : CLLocationDistance = 3000.0
        let longitudeMeters: CLLocationDistance = 3000.0
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(centerCoordinate, latitudinalMeters, longitudeMeters)
        mainMapView.setRegion(coordinateRegion, animated: true)
        
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

