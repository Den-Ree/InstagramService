//
//  LocationViewController.swift
//  InstagramAPI
//
//  Created by Admin on 06.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
  
    var locationId: String?
  
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idLabel.text?.append(locationId!)
        let request = Instagram.LocationsEndpoint.Get.location(id: locationId!)
        InstagramManager.shared.networkClient.send(request, completion: {
          (location: InstagramObjectResponse<Instagram.Location>?, error: Error?) in
            if error == nil{
              if let location = location?.data{
                if let name = location.name{
                  self.nameLabel.text?.append(name)
                }
                if let lat = location.latitude{
                  self.latLabel.text?.append(String(format: "%f", lat))
                }
                if let lng = location.longitude{
                  self.lngLabel.text?.append(String(format: "%f", lng))
                }
              }
            }
        })
    }
}
