//
//  FeatureViewController.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/9/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit
import Kingfisher

class FeatureViewController: UIViewController {
    
    var dataSource = [[String:AnyObject]]()
    @IBOutlet weak var collectionView: UICollectionView!
    var searchString : String?
    var searchController: UISearchController?
    weak var featureCell : FeatureViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.HTTP()
        self.setupSearch()
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
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        })
            
        task.resume()
    }
}


// MARK: - Collection view data source


extension FeatureViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureViewCell", for: indexPath) as! FeatureViewCell
        let item = dataSource[indexPath.row]
//        let url = item["flag"] as? String
        
        cell.countryNameLabel?.text = item["name"] as? String
//        cell.downloadImg(using: url!)
        cell.townName.text = item["capital"] as? String
        cell.regionLabel.text = item["region"] as? String
        cell.subRegionLabel.text = item["subregion"] as? String
        cell.isoCodeLabel.text = item["alpha3Code"] as? String
        
        
        return cell
    }
}

// MARK: - GridLayout


extension FeatureViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! GridLayout
        
        let availableWidth = collectionView.bounds.size.width
        let columns = 1
        var itemTotalWidth = availableWidth - CGFloat(columns-1) * layout.minimumInteritemSpacing
        itemTotalWidth -= (layout.sectionInset.left + layout.sectionInset.right)
        
        let itemWidth = itemTotalWidth / CGFloat(columns)
        return CGSize(width: itemWidth, height: self.collectionView.bounds.height)
    }
    
}


// MARK: - Search bar
extension FeatureViewController : UISearchResultsUpdating {
    
    func setupSearch() {
        
        searchController = {
            let sc = UISearchController(searchResultsController: nil)
            sc.searchResultsUpdater = self
            //
            sc.hidesNavigationBarDuringPresentation = false
            sc.dimsBackgroundDuringPresentation = false
            
            //
            sc.searchBar.searchBarStyle = UISearchBarStyle.prominent
            self.navigationItem.titleView = sc.searchBar
            sc.searchBar.sizeToFit()
            
            return sc
        }()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.searchString = searchController.searchBar.text
        self.collectionView.reloadData()
        
    }
    
    
}












