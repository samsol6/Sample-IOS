//
//  SearchTableViewCell.swift
//  RezList
//
//  Created by user 1 on 06/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var rent: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var persons: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
