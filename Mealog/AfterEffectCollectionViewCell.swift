//
//  AfterEffectCollectionViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/22.
//

import UIKit

class AfterEffectCollectionViewCell: UICollectionViewCell {
    var id: Int!
    var Image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setImage(image: UIImage?,i: Int){
    Image = image
    imageView.image = image
    id = i
    }
    
}
