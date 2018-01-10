//
//  TranslationView.swift
//  CountryFeature
//
//  Created by Lazar Andonov on 1/4/18.
//  Copyright © 2018 Lazar Andnov. All rights reserved.
//

import UIKit

class TranslationView: UIView {
    
    @IBOutlet weak var lbl1 : UILabel!
    @IBOutlet weak var lbl2 : UILabel!
    @IBOutlet weak var lbl3 : UILabel!
    @IBOutlet weak var lbl4 : UILabel!
    @IBOutlet weak var lbl5 : UILabel!
    @IBOutlet weak var lbl6 : UILabel!
    @IBOutlet weak var lbl7 : UILabel!
    @IBOutlet weak var lbl8 : UILabel!
    @IBOutlet weak var lbl9 : UILabel!
    @IBOutlet weak var lbl10 : UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(roundf(Float(5)))
    }
    
    func initialize(data: [String]) {
        lbl1.text = data[0]
        lbl2.text = data[1]
        lbl3.text = data[2]
        lbl4.text = data[3]
        lbl5.text = data[4]
        lbl6.text = data[5]
        lbl7.text = data[6]
        lbl8.text = data[7]
        lbl9.text = data[8]
        lbl10.text = data[9]
    }

}
