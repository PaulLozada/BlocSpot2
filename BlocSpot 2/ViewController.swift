//
//  ViewController.swift
//  BlocSpot 2
//
//  Created by Paul Lozada on 2015-06-11.
//  Copyright © 2015 Paul Lozada. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UISearchBarDelegate {
    
    
    //MARK: Temporary Storage
    
    //Will implement CoreData as permanent data persistence in the future
    
    var searchResult : String? = nil
    
    let searchRequest = MKLocalSearchRequest()

    
    
    //MARK: UISearchBarDelegate
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        print("Bookmark button pressed")
    }
   
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        
        searchBar.endEditing(true)
        
        print("Cancelled Search")
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let localSearch = MKLocalSearch(request: searchRequest)
        searchRequest.naturalLanguageQuery = searchResult
        
        localSearch.startWithCompletionHandler { (response, error) -> Void in
            
            if response != nil{
                print(response)
            } else{
                
                let alert = UIAlertController(title: "No Results Found", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okay = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                
                alert.addAction(okay)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        
        
        print(searchResult!)
        print("Search Button Clicked")
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        segmented.tintColor = UIColor(red: 0.175, green: 0.727, blue: 0.831, alpha: 1)
      
        
        searchBar.placeholder = "Type Search here"
        searchBar.prompt = "BlocSpot"
        searchBar.tintColor = UIColor(red: 0.175, green: 0.727, blue: 0.831, alpha: 1)
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        searchBar.showsCancelButton = true
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

