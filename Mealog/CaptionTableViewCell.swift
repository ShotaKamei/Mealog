//
//  CaptionTableViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class CaptionTableViewCell: UITableViewCell {


    @IBOutlet weak var textField: PlaceTextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var images: Array<UIImage>!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellWidth:CGFloat = 130
        let cellHeight:CGFloat = cellWidth
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 0.0
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        textField.placeHolder = "write a caption."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @objc func dismissKeyboard() {
        if (self.textField.isFirstResponder) {
                self.textField.resignFirstResponder()
            }
        }
    
}
extension CaptionTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.setImage(image: images[indexPath.item])
        return cell
    }
    
    
}

