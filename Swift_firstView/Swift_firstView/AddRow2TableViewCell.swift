//
//  AddRow2TableViewCell.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 28/01/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class AddRow2TableViewCell: UITableViewCell {

    @IBOutlet weak var addRowImage: UIImageView!
    @IBOutlet weak var addRowLabel: UILabel!
    @IBOutlet weak var addRowRating: RatingControlClass!
    
    @IBOutlet var addRowImage1: UIImageView!
    @IBOutlet var addRowLabel1: UILabel!
    @IBOutlet var addRowRating1: RatingControlClass!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }

}
