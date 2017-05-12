//
//  FeatureViewController.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/9/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController {
    
    var dataSource = [[String:AnyObject]]()
    @IBOutlet weak var collectionView: UICollectionView!

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
        
        cell.countryNameLabel?.text = item["name"] as? String
        
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



