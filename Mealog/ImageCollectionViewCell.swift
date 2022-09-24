//
//  ImageCollectionViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func setImage(image: UIImage){
        imageView.image = image
        print(image.size)
    }

}
