//
//  SlideImageViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/19.
//

import UIKit
import AVFoundation
class SlideImageViewController: UIViewController, UIScrollViewDelegate {

    var selectimage: UIImage!
    var selectnumber: Int!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!

    var x: CGFloat! = 0.0
    var y: CGFloat! = 0.0
    var width: CGFloat! = 0.0
    var height: CGFloat! = 0.0
    var im_width: CGFloat!
    var im_height: CGFloat!
    var imageSize: CGSize!
    var start_scale: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.delegate = self
        setImage()
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imageView
        }
            
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func exportImage() -> UIImage{
        let im = selectimage.reSizeImage(reSize: CGSize(width: imageSize.width*(scrollview.zoomScale/start_scale), height: imageSize.height*(scrollview.zoomScale/start_scale)))
        
        return im.cropping(to: CGRect(x: scrollview.bounds.origin.x+scrollview.contentInset.left, y: scrollview.bounds.origin.y+scrollview.contentInset.top, width: scrollview.bounds.width, height: scrollview.bounds.height))!
    }

    func setImage(){
        imageView.frame.origin.x = x
        imageView.frame.origin.y = y
        imageView.frame.size.width = width
        imageView.frame.size.height = height
        imageView.image = selectimage
        scrollview.frame.origin.x = x
        scrollview.frame.origin.y = y
        scrollview.frame.size.width = width
        scrollview.frame.size.height = height
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        if selectimage != nil{
        im_width = selectimage.size.width
        
            im_height = selectimage.size.height
        if im_width < im_height{
            scrollview.zoomScale = im_height/im_width
            scrollview.minimumZoomScale = scrollview.zoomScale
            imageSize = AVMakeRect(aspectRatio: selectimage.size, insideRect: self.imageView.frame).size
            scrollview.contentInset.left = (imageSize.width - imageView.frame.width)/2
            scrollview.contentInset.right = (imageSize.width - imageView.frame.width)/2
        }
        else{
            scrollview.zoomScale = im_width/im_height
            scrollview.minimumZoomScale = scrollview.zoomScale
            imageSize = AVMakeRect(aspectRatio: selectimage.size, insideRect: self.imageView.frame).size
            scrollview.contentInset.top = (imageSize.height - imageView.frame.height)/2
            scrollview.contentInset.bottom = (imageSize.height - imageView.frame.height)/2
        }
            start_scale = scrollview.zoomScale
        }
        
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageSize = AVMakeRect(aspectRatio: selectimage.size, insideRect: self.imageView.frame).size
        if im_width < im_height{
        scrollview.contentInset.left = (imageSize.width - imageView.frame.width)/2
        scrollview.contentInset.right = (imageSize.width - imageView.frame.width)/2
        }
        else{
            scrollview.contentInset.top = (imageSize.height - imageView.frame.height)/2
            scrollview.contentInset.bottom = (imageSize.height - imageView.frame.height)/2
        }
    }
 
}

extension UIImage {
    func cropping(to: CGRect) -> UIImage? {
            var opaque = false
            if let cgImage = cgImage {
                switch cgImage.alphaInfo {
                case .noneSkipLast, .noneSkipFirst:
                    opaque = true
                default:
                    break
                }
            }

            UIGraphicsBeginImageContextWithOptions(to.size, opaque, scale)
            draw(at: CGPoint(x: -to.origin.x, y: -to.origin.y))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
    }
    func reSizeImage(reSize:CGSize)->UIImage {
           //UIGraphicsBeginImageContext(reSize);
           UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
           self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
           let reSizeImage:UIImage! = UIGraphicsGetImageFromCurrentImageContext();
           UIGraphicsEndImageContext();
           return reSizeImage;
       }
    func scaleImage(scaleSize:CGFloat)->UIImage {
            let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
            return reSizeImage(reSize: reSize)
        }
}
