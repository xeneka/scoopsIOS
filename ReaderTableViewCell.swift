//
//  ReaderTableViewCell.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 30/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class ReaderTableViewCell: UITableViewCell {

     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBOutlet weak var imageNew: UIImageView!
    
    
    @IBOutlet weak var titleNew: UILabel!
    
    

}
