//
//  FetchedDataTCell.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 25/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class FetchedDataTCell: UITableViewCell {

    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var downImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
