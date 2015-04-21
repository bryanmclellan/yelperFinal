//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Bryan McLellan on 4/20/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate {
    func getFilters(filter: FiltersViewController, didUpdateFilters deals: Bool, didUpdateSort segment: Int, didUpdateRadius radius: Float)
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, SortCellDelegate, RadiusCellDelegate {

    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var dealsOn: Bool! = false
    var segmentIndex: Int! = 0
    var radiusDistance: Float! = 0
    var delegate: FiltersViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func searchBarButtonPressed(sender: AnyObject) {
        NSLog("calling the filter search")
        dismissViewControllerAnimated(true, completion: nil)
        NSLog("dealsOn in searchBar button pressed is \(dealsOn)")
        delegate?.getFilters(self, didUpdateFilters: dealsOn, didUpdateSort: segmentIndex, didUpdateRadius: radiusDistance)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
//            var cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell",) as! SwitchCell
            cell.nameLabel.text = "Deals"
            cell.delegate = self
//            NSLog("the cell's dealsOn is \(dealsOn)")
//            if let value = dealsOn{
//                cell.nameSwitch.on = value
//            }
//            else{
//                cell.nameSwitch.on = false
//            }
            dealsOn = cell.nameSwitch.on
            return cell
        }
        else if (indexPath.section == 1){
            var cell = tableView.dequeueReusableCellWithIdentifier("SortCell", forIndexPath: indexPath) as! SortCell
//            var cell = tableView.dequeueReusableCellWithIdentifier("SortCell") as! SortCell
            cell.delegate = self
            return cell
        }
        else if (indexPath.section == 2){
            var cell = tableView.dequeueReusableCellWithIdentifier("RadiusCell", forIndexPath: indexPath) as! RadiusCell
            cell.delegate = self
            return cell
        }
        else{
            var cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            NSLog("didnt get a good cell")
            return cell
        }
    }
    
    func segmentFlipped(sortCell: SortCell, segment index: Int) {
        segmentIndex = index
    }
    
    func segmentChanged(radiusCell: RadiusCell, slide radius: Float) {
        radiusDistance = radius
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 1){
            return "SORT"
        }
        else if section == 2 {
            return "RADIUS"
        }
        else{
            return ""
        }
    }
    
    func SwitchCellFlipped(cell: SwitchCell, valueDidChange value: Bool) {
        dealsOn = value
        NSLog("value is \(value)")
        NSLog("got to the filters view controller")

    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
