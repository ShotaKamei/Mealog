//
//  CollectionViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/18.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    
    func setImage(image: UIImage?){
        self.ImageView.image = image
        print(ImageView.bounds.width,ImageView.bounds.height)
    }

}
