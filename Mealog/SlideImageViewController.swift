//
//  SlideImageViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/19.
//

import UIKit

class SlideImageViewController: UIViewController {

    var selectimage: UIImage!
    var selectnumber: Int!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setImage(){
        imageView.image = selectimage
    }


}
