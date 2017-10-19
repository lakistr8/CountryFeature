//
//  FeatureViewController.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/9/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class FeatureViewController: UIViewController {
    
    var dataSource : [FeatureCellData] = []
    @IBOutlet weak var collectionView: UICollectionView!
    var searchString : String?
    var searchController: UISearchController?
    weak var featureCell : FeatureViewCell!
    let url = URL(string: "https://restcountries.eu/rest/v2/all")!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.HTTP(using: url)
        setupSearch()
        
    }
    
    func HTTP(using string: URL) {
        Alamofire.request(string).responseJSON { response in
            if let json = response.result.value {
                let jSON = JSON(json).array
                for item in jSON! {
                    self.dataSource.append(FeatureCellData(data: item))
                    self.searchString = item["name"].string!
                }
//                print("\(jSON)")
                self.collectionView.reloadData()
            }
        }
        
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
        cell.initilaze(with: [dataSource[indexPath.row]])
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
        
        let enterName = searchController.searchBar.text
        for (index, item) in dataSource.enumerated() {
            if item.name == enterName {
                print("nasli")
                let scrollToIndexTo = IndexPath(item: index, section: 0)
                self.collectionView.scrollToItem(at: scrollToIndexTo, at: .left, animated: true)
                self.collectionView.reloadData()
            }
        }
    }
    
}
