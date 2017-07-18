//
//  SearchTableViewCell.swift
//  RezList
//
//  Created by user 1 on 06/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var beds: UILabel!
    @IBOutlet weak var baths: UILabel!
    @IBOutlet weak var area: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
