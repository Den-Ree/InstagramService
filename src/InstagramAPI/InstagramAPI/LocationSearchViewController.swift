//
//  LocationSearchViewController.swift
//  InstagramAPI
//
//  Created by Admin on 06.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class LocationSearchViewController: UITableViewController {

    var locationSearchParameter: Instagram.LocationsEndpoint.Parameter.SearchMediaParameter?
    fileprivate var dataSource: [Instagram.Location]? = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = Instagram.LocationsEndpoint.Get.search(locationSearchParameter!)
        InstagramManager.shared.networkClient.send(request, completion: {
          (locations: InstagramArrayResponse<Instagram.Location>?, error: Error?) in
            if error == nil{
              self.dataSource = locations?.data
              self.tableView.reloadData()
            }
        })
  }

}
  extension LocationSearchViewController{
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.count)!
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationSearchCell", for: indexPath) as! LocationSearchCell
        let location = dataSource?[indexPath.row]
      
        cell.nameLabel.text?.append((location?.name)!)
        cell.idLabel.text?.append((location?.objectId)!)
        cell.latLabel.text?.append(String(format: "%f", (location?.latitude)!))
        cell.lngLabel.text?.append(String(format: "%f", (location?.longitude)!))
        return cell
    }

  }
    
    


