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
        let router = InstagramLocationRouter.getLocation(id: locationId!)
        //swiftlint:disable:next line_length
        InstagramClient().send(router, completion: { (location: InstagramModelResponse<InstagramLocation>?, error: Error?) in
          if error == nil {
            if let location = location?.data {
              self.nameLabel.text?.append(location.name)
              self.latLabel.text?.append(String(format: "%f", location.latitude))
              self.lngLabel.text?.append(String(format: "%f", location.longitude))
            }
          }
        })
    }
}
