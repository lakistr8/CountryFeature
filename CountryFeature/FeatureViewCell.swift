//
//  FeatureViewCell.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/9/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit
import Kingfisher

class FeatureViewCell: UICollectionViewCell {

    @IBOutlet weak var countryNameLabel : UILabel!
    @IBOutlet weak var flagImage : UIImageView!
    @IBOutlet weak var townName : UILabel!
    @IBOutlet weak var regionLabel : UILabel!
    @IBOutlet weak var subRegionLabel : UILabel!
    @IBOutlet weak var isoCodeLabel : UILabel!
    @IBOutlet weak var countryFeatureView : UIView!
    @IBOutlet weak var townView : UIView!
    @IBOutlet weak var nativeNameLabel : UILabel!
    var imgLink : String?
    
    
    func changeBorder() {
        self.townView.layer.masksToBounds = true
        self.townView.layer.cornerRadius  = CGFloat(roundf(Float(self.townView.frame.size.width/20.0)))
        
        self.countryFeatureView.layer.masksToBounds = true
        self.countryFeatureView.layer.cornerRadius  = CGFloat(roundf(Float(self.countryFeatureView.frame.size.width/20.0)))
    }
    
    func bcgImagefrom(url: URL, image: UIImageView) {
        image.contentMode = .scaleToFill
        downloadImage(url: url, image: image)
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    func downloadImage(url: URL, image: UIImageView) {
        getDataFromUrl(url: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                () -> Void in
                image.image = UIImage(data: data)
            }
        }
    }
    
    func initilaze(with data: [FeatureCellData]) {
        
        for item in data {
            self.countryNameLabel.text = item.name
            self.townName.text = item.townName
            self.regionLabel.text = item.region
            self.subRegionLabel.text = item.subRegion
            self.isoCodeLabel.text = item.iso
            self.nativeNameLabel.text = item.nativeName
            let url = URL(string: item.imgLing)!
            bcgImagefrom(url: url, image: self.flagImage)
        }
        
    }
    
}


