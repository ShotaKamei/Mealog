//
//  CategoryViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/24.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var AddButton: UIButton!
    var TableVC: CategoryTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        AddButton.tintColor = UIColor.white
        AddButton.layer.masksToBounds = true
        AddButton.layer.cornerRadius = 20
        AddButton.layer.borderWidth = 1
        AddButton.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AddButton.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategorySelectSegue" {
            TableVC = segue.destination as! CategoryTableViewController
        }
      }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func AddButton_taped(_ sender: Any) {
        TableVC.AddCategory()
        TableVC.set_Cursol()
        
        
    }
    
}
