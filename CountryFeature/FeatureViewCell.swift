//
//  FeatureViewCell.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/9/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit
//import Kingfisher

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
    
    
    func changeBorder() {
        self.townView.layer.masksToBounds = true
        self.townView.layer.cornerRadius  = CGFloat(roundf(Float(self.townView.frame.size.width/20.0)))
        
        self.countryFeatureView.layer.masksToBounds = true
        self.countryFeatureView.layer.cornerRadius  = CGFloat(roundf(Float(self.countryFeatureView.frame.size.width/20.0)))
    }
    
    func downloadImg(using string: String) {
        flagImage.image = nil
        guard
            let url = URL(string: string)
            else {
                return
        }
        
        flagImage.kf.setImage(with: url)

    }
    
}

