//
//  GridLayout.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/12/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.itemSize = CGSize(width: 365, height: 595)
        self.minimumInteritemSpacing = 1
        self.minimumLineSpacing = 1
        self.sectionInset = .zero
        self.scrollDirection = .horizontal
        
    }
    
    
}
