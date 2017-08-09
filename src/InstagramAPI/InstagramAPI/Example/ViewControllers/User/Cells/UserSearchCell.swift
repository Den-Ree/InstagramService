//
//  UserSearchCell.swift
//  InstagramAPI
//
//  Created by Yakovlev, Alexander on 1/10/17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class UserSearchCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

