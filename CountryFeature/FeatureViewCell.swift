//
//  FeatureViewCell.swift
//  CountryFeature
//
//  Created by Lazar Andnov on 5/9/17.
//  Copyright © 2017 Lazar Andnov. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class FeatureViewCell: UICollectionViewCell, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var lbl1 : UILabel!
    @IBOutlet weak var lbl2 : UILabel!
    @IBOutlet weak var lbl3 : UILabel!
    @IBOutlet weak var lbl4 : UILabel!
    @IBOutlet weak var lbl5 : UILabel!
    @IBOutlet weak var lbl6 : UILabel!
    
    

    @IBOutlet weak var countryNameLabel : UILabel!
    @IBOutlet weak var townName : UILabel!
    @IBOutlet weak var regionLabel : UILabel!
    @IBOutlet weak var subRegionLabel : UILabel!
    @IBOutlet weak var isoCodeLabel : UILabel!
    @IBOutlet weak var countryFeatureView : UIView!
    @IBOutlet weak var townView : UIView!
    @IBOutlet weak var nativeNameLabel : UILabel!
    @IBOutlet weak var populationLabel : UILabel!
    @IBOutlet weak var map: MKMapView!
    var coordinates: (Double, Double) = (1,1)
    var locationManager = CLLocationManager()
    
    func changeBorder() {
        self.townView.layer.masksToBounds = true
        self.townView.layer.cornerRadius  = CGFloat(roundf(Float(self.townView.frame.size.width/20.0)))
        
        self.countryFeatureView.layer.masksToBounds = true
        self.countryFeatureView.layer.cornerRadius  = CGFloat(roundf(Float(self.countryFeatureView.frame.size.width/20.0)))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        map.delegate = self
        map.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
        map.setRegion(viewRegion, animated: false)
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        circleViews()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        let center = CLLocationCoordinate2D(latitude: coordinates.0, longitude: coordinates.1)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        region.center = center
        map.setRegion(region, animated: true)
    }

    
    func initilaze(with data: [FeatureCellData]) {
        
        for item in data {
            self.countryNameLabel.text = item.name
            self.townName.text = item.townName
            self.regionLabel.text = item.region
            self.subRegionLabel.text = item.subRegion
            self.isoCodeLabel.text = item.iso
            self.nativeNameLabel.text = item.nativeName
            self.populationLabel.text = "\(item.population)"
            self.coordinates = item.latlng
            
        }
        
    }
    
    func circleViews() {
        
        lbl1.layer.masksToBounds = true
        lbl1.layer.cornerRadius = CGFloat(roundf(Float(5)))
        lbl2.layer.masksToBounds = true
        lbl2.layer.cornerRadius = CGFloat(roundf(Float(5)))
        lbl3.layer.masksToBounds = true
        lbl3.layer.cornerRadius = CGFloat(roundf(Float(5)))
        lbl4.layer.masksToBounds = true
        lbl4.layer.cornerRadius = CGFloat(roundf(Float(5)))
        lbl5.layer.masksToBounds = true
        lbl5.layer.cornerRadius = CGFloat(roundf(Float(5)))
        lbl6.layer.masksToBounds = true
        lbl6.layer.cornerRadius = CGFloat(roundf(Float(5)))
        
        
        countryNameLabel.layer.masksToBounds = true
        countryNameLabel.layer.cornerRadius = CGFloat(roundf(Float(5)))
        townName.layer.masksToBounds = true
        townName.layer.cornerRadius = CGFloat(roundf(Float(5)))
        regionLabel.layer.masksToBounds = true
        regionLabel.layer.cornerRadius = CGFloat(roundf(Float(5)))
        subRegionLabel.layer.masksToBounds = true
        subRegionLabel.layer.cornerRadius = CGFloat(roundf(Float(5)))
        isoCodeLabel.layer.masksToBounds = true
        isoCodeLabel.layer.cornerRadius = CGFloat(roundf(Float(5)))
        nativeNameLabel.layer.masksToBounds = true
        nativeNameLabel.layer.cornerRadius = CGFloat(roundf(Float(5)))
        populationLabel.layer.masksToBounds = true
        populationLabel.layer.cornerRadius = CGFloat(roundf(Float(5)))
        map.layer.masksToBounds = true
        map.layer.cornerRadius = CGFloat(roundf(Float(5)))
    }
    
    
}


