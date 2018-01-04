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

class FeatureViewController: UIViewController, iCarouselDelegate, iCarouselDataSource {
    
    @IBOutlet weak var carousel: iCarousel!
    @IBOutlet weak var img: UIImageView!
    var dataSource : [FeatureCellData] = []
    var searchString : String?
    var searchController: UISearchController?
    let url = URL(string: "https://restcountries.eu/rest/v2/all")!

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                let jSON = JSON(json).array
                for item in jSON! {
                    self.dataSource.append(FeatureCellData(data: item))
                    self.searchString = item["name"].string!
                }
                self.carousel.reloadData()
                self.carousel.type = .cylinder
            }
        }
//        setupSearch()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return dataSource.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let subVIEW = UINib(nibName: "CountryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FeatureViewCell
        subVIEW.frame.origin.y = self.view.frame.origin.y + 150
        subVIEW.frame.origin.x = 0
        subVIEW.frame.size.width = self.view.frame.size.width
        subVIEW.frame.size.height = self.img.frame.size.height
        subVIEW.initilaze(with: [dataSource[index]])
        return subVIEW
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.2
        }
        return value
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
                let scrollToItem = IndexPath(item: index, section: 0)
//                self.carousel.scrollToItem(at: scrollToItem, at: .left, animated: true)
                self.carousel.reloadData()
            }
        }
    }
    
}
