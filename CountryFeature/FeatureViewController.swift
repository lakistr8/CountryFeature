//
//  FeatureViewController.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/9/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit

class FeatureViewController: UITableViewController {
    
    var dataSource = [[String:AnyObject]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.HTTP()
    }
    
    func HTTP() {
        let session = URLSession.shared
        let url = URL(string: "https://restcountries.eu/rest/v2/all")!
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if (error != nil) {
                print(error.debugDescription)
            }else{
                do{
                    self.dataSource = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:AnyObject]]
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        })
            
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureViewCell", for: indexPath)
        let item = dataSource[indexPath.row]
        cell.textLabel?.text = item["name"] as? String
        

        return cell
    }
}
