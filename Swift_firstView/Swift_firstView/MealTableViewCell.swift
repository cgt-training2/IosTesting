//
//  MealTableViewCell.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 27/01/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: UIView!
    
    @IBOutlet var nameLabel1: UILabel!
    @IBOutlet var photoImageView1: UIImageView!
    
    @IBOutlet var ratingControl1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
