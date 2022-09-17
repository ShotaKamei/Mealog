//
//  SelectorViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/18.
//

import UIKit
import Photos
class SelectorViewController: UIViewController {

    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        photos = camerarollAssets()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if !requestPhotoLibraryAuthorization(){
            let dialog = UIAlertController(title: "写真を読み込めません", message: "写真のアクセスを許可してください。", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler:{
                    (action: UIAlertAction!) -> Void in
                    if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    
                }))
            
              // 生成したダイアログを実際に表示します
              present(dialog, animated: true, completion: nil)
            
        }
        else{
            
        }
        
    }
    
    
    func requestPhotoLibraryAuthorization() -> Bool {
        var isAuthorized: Bool = false
        
        let semaphore: DispatchSemaphore = DispatchSemaphore.init(value: 0)
        
        PHPhotoLibrary.requestAuthorization({ status in
            isAuthorized = status == .authorized
            semaphore.signal()
        })
        
        semaphore.wait()
        
        return isAuthorized
    }
    
    private var photos: [PHAsset] = [] {
            didSet {
                CollectionView.reloadData()
            }
        }
    
    private func camerarollAssets() -> [PHAsset] {
            var photoAssets: Array! = [PHAsset]()
            let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: nil)
            assets.enumerateObjects({ (asset, index, stop) -> Void in
                photoAssets.append(asset as PHAsset)
            })
            return photoAssets.reversed()
        }
    
    private func thumbnail(asset: PHAsset) -> UIImage? {
            var assetImage: UIImage?
            
            let manager = PHImageManager()
            let options = PHImageRequestOptions()
            options.deliveryMode = .opportunistic
            options.resizeMode = .fast
            options.isSynchronous = true
            options.isNetworkAccessAllowed = true
            manager.requestImage(for: asset,
                                    targetSize: CGSize(width: 100, height: 100),
                                    contentMode: .aspectFill,
                                    options: options,
                                    resultHandler: { (image, info) in
                assetImage = image
            })
            
            return assetImage
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CollectionViewCell
                let image = thumbnail(asset: photos[indexPath.item])
                cell.setImage(image: image)
        print("set")
                return cell
    }
}
extension SelectorViewController: UICollectionViewDelegateFlowLayout {
    
    /// セルサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横に４列表示する
        let cellWidth:CGFloat = collectionView.bounds.width / 4
        let cellHeight:CGFloat = cellWidth
        print(cellWidth, cellHeight)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    

}

