//
//  ResultsViewController.swift
//  Yelp
//
//  Created by Bryan McLellan on 4/19/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FiltersViewControllerDelegate  {
    var client: YelpClient!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    var searchWord = ""
    var dealsOn : Bool = false
    var sortNumber:Int = 0
    var radiusFilter: Float = 40000.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var searchBar: UISearchBar!
    
    var results: [NSDictionary]! = [NSDictionary]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: screenSize.width - 50, height: 30))
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.barTintColor = UIColor(red: 196/255.0, green: 18/255.0, blue: 0.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
//            NSLog("searching regularly")
//        client.searchWithTerm(searchWord, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
//            self.results = response["businesses"] as! [NSDictionary]
//            self.tableView.reloadData()
//            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//                println(error)
//        }
        
        search(client, areTheDealsOn: dealsOn, segmentIndex: sortNumber, radius: radiusFilter)

        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func search(client: YelpClient, areTheDealsOn: Bool, segmentIndex: Int, radius: Float){
        client.filterSearch(searchWord, deals: areTheDealsOn, segmentIndex: segmentIndex, radius: radius, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.results = response["businesses"] as! [NSDictionary]
            NSLog("dealsOn is \(self.dealsOn)")
            self.tableView.reloadData()
            NSLog("\(self.results)")
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    func getFilters(filter: FiltersViewController, didUpdateFilters deals: Bool, didUpdateSort segment: Int, didUpdateRadius radius:Float){
        
        dealsOn = deals
        sortNumber = segment
        radiusFilter = radius
        search(client, areTheDealsOn: dealsOn, segmentIndex: sortNumber, radius: radiusFilter)
        NSLog("before searching")
        NSLog(" deals is \(deals)")
        NSLog(" dealsOn is \(dealsOn)")
        NSLog("got to the results view controller")
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchWord = searchText
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        client.searchWithTerm(searchWord, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        self.results = response["businesses"] as! [NSDictionary]
                        self.tableView.reloadData()
                        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                            println(error)
                    }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchWord = ""
        searchBar.resignFirstResponder()
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath) as! ResultCell
        var result = results[indexPath.row]
        cell.nameLabel.text = result["name"] as! String
        cell.nameLabel.sizeToFit()
        var url = result.valueForKeyPath("image_url") as? String
        cell.thumbnailImageView.setImageWithURL(NSURL(string: url!)!)
        var url1 = result.valueForKeyPath("rating_img_url_large") as? String
        cell.ratingImageView.setImageWithURL(NSURL(string: url1!)!)
       // cell.ratingImageView.frame = (CGRect(x: cell.ratingImageView.frame.origin.x, y: cell.ratingImageView.frame.origin.y, width: 100, height: 20))
            
        var addressArray = result.valueForKeyPath("location.address") as! [String]
        if addressArray.count != 0 {
        var addressTemp = addressArray[0]
        addressTemp +=  ", "
        var addressTemp1 = result.valueForKeyPath("location.city") as! String
        addressTemp += addressTemp1
        cell.addressLabel.text = addressTemp
        cell.addressLabel.sizeToFit()
        }
        var tagArray = result.valueForKeyPath("categories") as! [[String]]
        var tagTemp = ""
        for (var i = 0; i < tagArray.count-1; i++){
            tagTemp += tagArray[i][0]
            tagTemp += ", "
        }
        tagTemp += tagArray[tagArray.count-1][0]
        cell.tagsLabel.text = tagTemp
        cell.tagsLabel.sizeToFit()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "PresentFilters" {
            let filtersNC = segue.destinationViewController as! UINavigationController
            let filtersVC = filtersNC.viewControllers[0] as! FiltersViewController
            filtersVC.delegate = self
        }
    }


}
