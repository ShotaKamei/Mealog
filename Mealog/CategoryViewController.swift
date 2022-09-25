//
//  CategoryViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/24.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var AddButton: UIButton!
    var TableVC: CategoryTableViewController!
    var select_categorys: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        AddButton.tintColor = UIColor.white
        AddButton.layer.masksToBounds = true
        AddButton.layer.cornerRadius = 20
        AddButton.layer.borderWidth = 1
        AddButton.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = self
        let NVC = presentingViewController as! UINavigationController

        let VC = NVC.viewControllers
        print(VC,"wowow")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AddButton.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategorySelectSegue" {
            TableVC = segue.destination as? CategoryTableViewController
            TableVC.select_categorys = select_categorys
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
extension CategoryViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("kottri?")
       }
       //  検索バーに入力があったら呼ばれる
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           TableVC.search(label: searchText)
       }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
