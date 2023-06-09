//
//  PlayersTableViewCell.swift
//  Sports
//
//  Created by Ahmed on 06/05/2023.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    @IBOutlet weak var playerNumberLabel: UILabel!
    
  

    
    @IBOutlet weak var playerFavButton: UIButton!
    
    var buttonAction: ((PlayersTableViewCell) -> Void)?
    
    @IBAction func playFavAction(_ sender: Any) {
        buttonAction?(self)

    }
}
