//
//  HomeCollectionViewController.swift
//  Sports
//
//  Created by Ahmed on 01/05/2023.
//

import UIKit


class HomeCollectionViewController: UICollectionViewController ,
UICollectionViewDelegateFlowLayout{

    override func viewDidLoad() {
        super.viewDidLoad()

    }

 
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
/*
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
       let viewWidth = collectionView.frame.width
        
       let width =  (viewWidth - 10 )/2
        let height = viewWidth * 1.5
       
        
      /* let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        */
        return CGSize(width: width, height: height)
    }*/
    
    
    let imageNames = ["football_img", "basketball_img", "tennis_img", "cricket_img"]
    let  sportsNames = ["Football", "Basketball", "Tennis", "Cricket"]
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! HomeCollectionViewCell
    
        let imageName = imageNames[indexPath.row]
          cell.imageSport.image = UIImage(named: imageName)
        
        
        let sportName = sportsNames[indexPath.row]
          cell.sportNameLabel.text = sportName
        
     
        return cell
    }

   
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var sportsTVC =  self.storyboard?.instantiateViewController(withIdentifier: "sportsTable") as! SportsTableViewController
        
        sportsTVC.sportName = sportsNames[indexPath.row]
        
        self.navigationController?.pushViewController(sportsTVC, animated: true)
        
    }

}
