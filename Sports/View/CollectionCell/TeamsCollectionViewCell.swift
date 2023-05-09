//
//  TeamsCollectionViewCell.swift
//  Sports
//
//  Created by Ahmed on 04/05/2023.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamsImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        teamsImage.layer.cornerRadius = teamsImage.bounds.size.width/2
    }

}
