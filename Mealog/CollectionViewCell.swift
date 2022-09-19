//
//  CollectionViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/18.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var SelectLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        SelectLabel.text = " "
        let borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
        let backgroundcolor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor
        SelectLabel.layer.borderColor = borderColor
        SelectLabel.layer.backgroundColor = backgroundcolor
        SelectLabel.layer.borderWidth = 1
        SelectLabel.layer.cornerRadius = 10.5
        // Initialization code
        
    }
    
    
    func setImage(image: UIImage?){
        self.ImageView.image = image
    }
    
    func setCheck(number: Int){
        SelectLabel.text = String(number)
        SelectLabel.layer.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1).cgColor
    }
    func dissetCheck(){
        SelectLabel.text = ""
        SelectLabel.layer.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor
    }

}
