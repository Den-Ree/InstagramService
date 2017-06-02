//
//  RelationshipCellTableViewCell.swift
//  InstagramAPI
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class RelationshipCell: UITableViewCell {

  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
