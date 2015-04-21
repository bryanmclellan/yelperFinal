//
//  SortCell.swift
//  Yelp
//
//  Created by Bryan McLellan on 4/20/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol SortCellDelegate{
    func segmentFlipped(sortCell: SortCell, segment index:Int)
}

class SortCell: UITableViewCell {

    @IBOutlet weak var sortSegment: UISegmentedControl!
    var segmentIndex: Int!
    var delegate:SortCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        segmentIndex = sender.selectedSegmentIndex
        delegate?.segmentFlipped(self, segment: segmentIndex)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
