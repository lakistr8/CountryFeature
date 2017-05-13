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

