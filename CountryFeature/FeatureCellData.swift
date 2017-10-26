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
    var translations : [String] = []
    var borders : [String] = []
    var languages : [Any] = []
    
    
    init(data: JSON) {
        name = data["name"].string!
        townName = data["capital"].string!
        region = data["region"].string!
        subRegion = data["subregion"].string!
        iso = data["alpha3Code"].string!
        nativeName = data["nativeName"].string!
        population = data["population"].int!
        latlng = data["latlng"].arrayValue.map({$0.doubleValue})
        translations = data["translations"].dictionaryValue.map({$1.stringValue})
        borders = data["borders"].arrayValue.map({$0.stringValue})
        languages = data["languages"].arrayValue.map({$0.dictionaryObject!})
    }
}
