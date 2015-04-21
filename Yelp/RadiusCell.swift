//
//  RadiusCell.swift
//  Yelp
//
//  Created by Bryan McLellan on 4/20/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol RadiusCellDelegate{
    func segmentChanged(radiusCell: RadiusCell, slide radius:Float)
}

class RadiusCell: UITableViewCell {
    var radius: Int!
    @IBOutlet weak var radiusSlider: UISlider!
    
    @IBOutlet weak var distance: UILabel!
    var delegate: RadiusCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        distance.text = "Current Radius"
        // Initialization code
    }
    
    
    

    
    @IBAction func segmentSlid(sender: UISlider) {
        radius = Int(sender.value * 0.000621371)
        distance.text = "Current Radius: \(radius) mi."
        NSLog("\(radius)")
        delegate?.segmentChanged(self, slide: sender.value)
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
