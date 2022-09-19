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
    @IBOutlet weak var ScrollView: UIScrollView!
    var ImageView = UIImageView()
    var selectnumber:Array<Int> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        photos = camerarollAssets()
        ScrollView.delegate = self
                // 最大倍率・最小倍率を設定する
        ScrollView.maximumZoomScale = 5.0
        ScrollView.minimumZoomScale = 1.0
        ImageView.frame = CGRect(x:0,y:0,width:view.frame.width,height:view.frame.height)
        ImageView.image = originalImage(asset: photos[0])
        ScrollView.addSubview(ImageView)
        ImageView.contentMode = .scaleAspectFit
        ScrollView.showsVerticalScrollIndicator = false
        ScrollView.showsHorizontalScrollIndicator = false
        CollectionView.allowsMultipleSelection = false
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
    
    private func originalImage(asset: PHAsset) -> UIImage? {
        var assetImage: UIImage?

        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        PHImageManager.default().requestImageDataAndOrientation(for: asset, options: options) { imageData, dataUTI, orientation, info in
            if let imageData = imageData {
                assetImage = UIImage.init(data: imageData)
            }
        }

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
        if selectnumber.contains(indexPath.item){
            cell.setCheck(number: (selectnumber.firstIndex(of: indexPath.item)!+1))
        }
        else{
            cell.dissetCheck()
        }
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CollectionViewCell = CollectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        if selectnumber.contains(indexPath.item){
            cell.dissetCheck()
            selectnumber.removeAll(where: {$0 == indexPath.item})
            reloadcell()
        }
        else{
            if selectnumber.count < 10{
            selectnumber.append(indexPath.item)
            cell.setCheck(number: (selectnumber.count))
            ImageView.image = originalImage(asset: photos[indexPath.item])
            }
        }
        
    }
    
    func reloadcell(){
        for (i, value) in selectnumber.enumerated(){
            let cell: CollectionViewCell = CollectionView.cellForItem(at: [0, value]) as! CollectionViewCell
            cell.setCheck(number: (i+1))
        }
    }
}
extension SelectorViewController: UICollectionViewDelegateFlowLayout {
    
    /// セルサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横に４列表示する
        let cellWidth:CGFloat = collectionView.bounds.width / 4
        let cellHeight:CGFloat = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    

}
extension SelectorViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.ImageView
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            // ズーム終了時の処理
        }

        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            // ズーム開始時の処理
        }

        func zoomForScale(scale:CGFloat, center: CGPoint) -> CGRect{
            print("jijj")
            var zoomRect: CGRect = CGRect()
            zoomRect.size.height = self.ScrollView.frame.size.height / scale
            zoomRect.size.width = self.ScrollView.frame.size.width  / scale
            zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
            zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
            return zoomRect
        }
}

