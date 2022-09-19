//
//  SelectorViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/18.
//

import UIKit
import Photos
import CropViewController

class SelectorViewController: UIViewController{

    @IBOutlet weak var pagecontroll: UIPageControl!
    @IBOutlet weak var CollectionView: UICollectionView!
    //@IBOutlet weak var ScrollView: UIScrollView!
    var ImageView = UIImageView()
    var pageViewController: UIPageViewController?
    var selectnumber:Array<Int> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController = children.first! as? UIPageViewController
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        CollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        photos = camerarollAssets()
        pagecontroll.numberOfPages = selectnumber.count
        pagecontroll.currentPage = 0
        /*ScrollView.delegate = self
                // 最大倍率・最小倍率を設定する
        ScrollView.maximumZoomScale = 5.0
        ScrollView.minimumZoomScale = 1.0*/
        ImageView.frame = CGRect(x:0,y:0,width:view.frame.width,height:view.frame.height)
        ImageView.image = originalImage(asset: photos[0])
        //ScrollView.addSubview(ImageView)
        ImageView.contentMode = .scaleAspectFit
        //ScrollView.showsVerticalScrollIndicator = false
        //ScrollView.showsHorizontalScrollIndicator = false
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
    var cnt = 0
    func setViewController() {
            if cnt < selectnumber.count {
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "SlideImageViewController") as! SlideImageViewController
                // 遷移先のViewControllerにpalletの色を送る
                contentVC.selectimage = originalImage(asset: photos[selectnumber.last!])
                pagecontroll.numberOfPages = selectnumber.count
                contentVC.selectnumber = selectnumber.last
                cnt =  selectnumber.count - 1
                pagecontroll.currentPage = cnt
                // PageViewControllerにViewControllerをセット
                self.pageViewController?.setViewControllers([contentVC], direction: .forward, animated: true,completion: nil)
            }
        }
    func desetViewController() {
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "SlideImageViewController") as! SlideImageViewController
                // 遷移先のViewControllerにpalletの色を送る
        if selectnumber.count > 0{
                contentVC.selectimage = originalImage(asset: photos[selectnumber.last!])
                contentVC.selectnumber = selectnumber.last
        }
                cnt =  selectnumber.count - 1
                pagecontroll.numberOfPages = selectnumber.count
                pagecontroll.currentPage = cnt
                // PageViewControllerにViewControllerをセット
                self.pageViewController?.setViewControllers([contentVC], direction: .forward, animated: false,completion: nil)
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func pagecontrolchanged(_ sender: UIPageControl) {
        print(sender.currentPage)
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "SlideImageViewController") as! SlideImageViewController
        // 遷移先のViewControllerにpalletの色を送る
        contentVC.selectimage = originalImage(asset: photos[selectnumber[sender.currentPage]])
        cnt =  sender.currentPage
        // PageViewControllerにViewControllerをセット
        self.pageViewController?.setViewControllers([contentVC], direction: .forward, animated: true,completion: nil)
    }
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
            desetViewController()
        }
        else{
            
            if selectnumber.count < 10{
            selectnumber.append(indexPath.item)
            cell.setCheck(number: (selectnumber.count))
            ImageView.image = originalImage(asset: photos[indexPath.item])
            setViewController()
                let cropViewController = CropViewController(croppingStyle: .default, image: originalImage(asset: photos[indexPath.item])!)
                cropViewController.delegate = self
                cropViewController.aspectRatioPreset = .presetSquare
                cropViewController.aspectRatioPickerButtonHidden = true
                cropViewController.resetButtonHidden = true
                cropViewController.aspectRatioLockEnabled = true
                cropViewController.cancelButtonHidden = false
                cropViewController.rotateButtonsHidden = true
                cropViewController.doneButtonHidden = false
                present(cropViewController, animated: true)
            }
        }
        
    }
    
    func reloadcell(){
        for (i, value) in selectnumber.enumerated(){
            if let cell: CollectionViewCell = CollectionView.cellForItem(at: [0, value]) as? CollectionViewCell{
            cell.setCheck(number: (i+1))
            setViewController()
            }
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
extension SelectorViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
          let contentVC = storyboard?.instantiateViewController(withIdentifier: "SlideImageViewController") as! SlideImageViewController
            if 0 < cnt {
                contentVC.selectimage = originalImage(asset: photos[selectnumber[cnt-1]])
                contentVC.selectnumber = selectnumber[cnt-1]
                return contentVC
            }
        else{
            return nil
        }
        }
        // Afterなので右側のViewController
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
               
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "SlideImageViewController") as! SlideImageViewController
            if cnt+1 < selectnumber.count {
                contentVC.selectimage = originalImage(asset: photos[selectnumber[cnt+1]])
                contentVC.selectnumber = selectnumber[cnt+1]
                return contentVC
            }
        else{
            return nil
        }
        }
    }

extension SelectorViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        // toIndexの部分はindexに変換する適当な処理
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let contentVC: SlideImageViewController = pageViewController.viewControllers?.first as! SlideImageViewController
            cnt = selectnumber.firstIndex(of: contentVC.selectnumber!)!
            pagecontroll.currentPage = cnt
            
        }
    }
    
}
extension SelectorViewController: CropViewControllerDelegate{
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int){
        dismiss(animated: true)
    }
}


