//
//  Tools_TableViewCell.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 12/04/23.
//

import UIKit

class Tools_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var Tool_image: UIImageView!
    @IBOutlet weak var Tool_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
