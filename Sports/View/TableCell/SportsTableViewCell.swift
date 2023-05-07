//
//  SportsTableViewCell.swift
//  Sports
//
//  Created by Ahmed on 02/05/2023.
//

import UIKit

class SportsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var leagueImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
