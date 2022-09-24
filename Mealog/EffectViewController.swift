//
//  EffectViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/21.
//

import UIKit

class EffectViewController: UIViewController {

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var EffectCollectionView: UICollectionView!
    var images: Array<UIImage>!
    var effectimages: Array<UIImage>!
    var Effect: Array<String> = ["Original", "Fade", "Instant", "Mono", "Noir", "Process", "Tonal", "Transfer"]
    var currentimage:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        effectimages = images
        CollectionView.delegate = self
        CollectionView.dataSource = self
        EffectCollectionView.delegate = self
        EffectCollectionView.dataSource = self
        let layout = CarouselCollectionViewFlowLayout()
        let layout2 = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 横スクロール
        layout2.scrollDirection = .horizontal
        let cellWidth:CGFloat = CollectionView.bounds.width * 0.7
        let cellHeight:CGFloat = cellWidth
        let cellWidth2:CGFloat = EffectCollectionView.bounds.width / 3
        let cellHeight2:CGFloat = cellWidth2 * (360/300)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout2.itemSize = CGSize(width: cellWidth2, height: cellHeight2)
        layout.minimumLineSpacing = CollectionView.bounds.width * 0.05
        layout.sectionInset.left = CollectionView.bounds.width * 0.125
        layout.sectionInset.right = CollectionView.bounds.width * 0.125
        CollectionView.collectionViewLayout = layout
        EffectCollectionView.collectionViewLayout = layout2
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.decelerationRate = .fast
        CollectionView.register(UINib(nibName: "AfterEffectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AfterEffectCell")
        EffectCollectionView.register(UINib(nibName: "EffectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EffectCell")
        // Do any  additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func changeImage(Image: UIImage, label: String) -> UIImage{
        let ciImg = Image.ciImage ?? CIImage(image: Image)
        if label != "Original"{
            let filter = CIFilter(name: ("CIPhotoEffect" + label))
            filter?.setValue(ciImg, forKey: kCIInputImageKey)
            if let filteredImage = filter?.outputImage {
                        return UIImage(ciImage: filteredImage)
                    }
            else{
                return Image
            }
        }
        else{
            return Image
        }

    }

    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "DetailViewSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailViewSegue" {
                let nextVC = segue.destination as! DetailTableViewController
                nextVC.images = effectimages
            }
        }
}
extension EffectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CollectionView{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AfterEffectCell", for: indexPath) as! AfterEffectCollectionViewCell
            cell.setImage(image: effectimages[indexPath.item], i: indexPath.item)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EffectCell", for: indexPath) as! EffectCollectionViewCell
            cell.Set(image: images[currentimage], label: Effect[indexPath.item])
            return cell
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CollectionView{
        return images.count
        }
        else{
            return Effect.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == EffectCollectionView{
            
            effectimages[currentimage] = changeImage(Image: images[currentimage], label: Effect[indexPath.item])
            CollectionView.reloadItems(at: [IndexPath(item: currentimage, section: 0)])
        }
                }

}
extension EffectViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.CollectionView{
        let perfectVisibleCells = CollectionView.visibleCells.filter {
            CollectionView.bounds.contains($0.frame)
            }
        let currentcell = perfectVisibleCells as! [AfterEffectCollectionViewCell]
            currentimage = (currentcell.first?.id) ?? currentimage
            EffectCollectionView.reloadData()
        }
        
    }
}

