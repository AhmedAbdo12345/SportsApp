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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImage.layer.cornerRadius = leagueImage.bounds.size.width/2
    }

}
