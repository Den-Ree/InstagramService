//
//  LocationSearchCell.swift
//  InstagramAPI
//
//  Created by Admin on 06.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class LocationSearchCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
  
    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var latLabel: UILabel!
  
    @IBOutlet weak var lngLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
