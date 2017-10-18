//
//  FeatureCellData.swift
//  CountryFeature
//
//  Created by Lazar Andonov on 10/10/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FeatureCellData {
    
    var name: String
    var townName: String
    var region: String
    var subRegion: String
    var iso: String
    var nativeName: String
    var population: Int
    var latlng : [Double] = []
    
    
    init(data: JSON) {
        name = data["name"].string!
        townName = data["capital"].string!
        region = data["region"].string!
        subRegion = data["subregion"].string!
        iso = data["alpha3Code"].string!
        nativeName = data["nativeName"].string!
        population = data["population"].int!
        latlng = data["latlng"].arrayValue.map({$0.doubleValue})
        
    }
}
