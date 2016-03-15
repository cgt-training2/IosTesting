//
//  RentCarApi_TableCell.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 02/03/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class RentCarApi_TableCell : UITableViewCell {
    
    
    @IBOutlet var carImage: UIImageView!
    
    @IBOutlet var carIdLabel: UILabel!
    
    @IBOutlet var carNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
