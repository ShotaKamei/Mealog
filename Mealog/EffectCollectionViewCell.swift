//
//  EffectCollectionViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class EffectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func Set(image: UIImage, label: String){
        imageView.image = image
        Label.text = label
        let ciImg = image.ciImage ?? CIImage(image: image)
        if label != "Original"{
            print("h")
            let filter = CIFilter(name: ("CIPhotoEffect" + label))
            filter?.setValue(ciImg, forKey: kCIInputImageKey)
            if let filteredImage = filter?.outputImage {
                        imageView.image = UIImage(ciImage: filteredImage)
                    }
        }
    }

}
