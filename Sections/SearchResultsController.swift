//
//  SearchResultsController.swift
//  Sections
//
//  Created by student on 3/9/19.
//  Copyright © 2019 Sean Klechak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    let sectionsTableIdentifier = "SectionsTableIdentifer"
    var names:[String: [String]] = [String: [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []
    
    private static let longNameSize = 6
    private static let shortNameButtonIndex = 1
    private static let longNamesButtonIndex = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredNames.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier)
        cell!.textLabel?.text = filteredNames[indexPath.row]
        return cell!
    }
    
    
    // MARK: UISearchResultsUpdating Conformance

    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
            filteredNames.removeAll(keepingCapacity: true)
            
            if !searchString.isEmpty {
                let filter: (String) -> Bool = { name in
                let nameLength = name.characters.count
                if (buttonIndex == SearchResultsController.shortNameButtonIndex && nameLength >= SearchResultsController.longNameSize)
                    || (buttonIndex == SearchResultsController.longNamesButtonIndex && nameLength < SearchResultsController.longNameSize) {
                    return false
                    }
    
                    let range = name.range(of: searchString, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                    //  let range = name.rangeOfString(searchString, options:NSString.CompareOptions.CaseInsenstiveSearch
                    return range != nil

                    
                }
                for key in keys {
                    let namesForKey = names[key]!
                    let matches = namesForKey.filter(filter)
                    filteredNames += matches
                    
                }
            }
        }
        tableView.reloadData()
    }
    

}

 

