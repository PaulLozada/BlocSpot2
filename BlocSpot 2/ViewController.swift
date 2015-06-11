//
//  ViewController.swift
//  BlocSpot 2
//
//  Created by Paul Lozada on 2015-06-11.
//  Copyright © 2015 Paul Lozada. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    
    //MARK: UISearchBarDelegate
    
    
   
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Type Search here"
        searchBar.prompt = "BlocSpot"
        searchBar.tintColor = UIColor(red: 0.175, green: 0.727, blue: 0.831, alpha: 1)
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

