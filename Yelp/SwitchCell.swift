//
//  SwitchCell.swift
//  Yelp
//
//  Created by Bryan McLellan on 4/20/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate{
    func SwitchCellFlipped(SwitchCell: SwitchCell, valueDidChange value:Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameSwitch: UISwitch!
    var delegate:SwitchCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchFlipped(sender: UISwitch) {
        delegate?.SwitchCellFlipped(self, valueDidChange: sender.on)
    }

}
