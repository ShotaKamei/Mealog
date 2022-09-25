//
//  CategoryTableViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/24.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    var tableviewcount: Int!
    let realm = try! Realm()
    var categorys: Results<Candidate>!
    var use_categorys: Array<String> = []
    var select_categorys: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Category_selectTableViewCell", bundle: nil), forCellReuseIdentifier: "Category_selectCell")
        tableView.register(UINib(nibName: "AddCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCategoryCell")
        categorys = realm.objects(Candidate.self)
        for value in categorys{
            print(value)
            use_categorys.append(value.category)
        }
        tableviewcount = categorys.count
        tableView.allowsMultipleSelection = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func AddCategory(){
        tableviewcount += 1
        tableView.reloadData()
    }
    
    func Category_add(label: String){
        if categorys.filter("category == %@", label).count == 0{
            let category = Candidate()
            category.category = label
            try! realm.write {
              realm.add(category, update: .modified) // <- これで落ちない
            }
            use_categorys = []
            for value in categorys{
                use_categorys.append(value.category)
            }
        }
        else{
            tableviewcount -= 1
        }
        tableView.reloadData()
    }
    
    func Category_delete(){
        tableviewcount -= 1
        tableView.reloadData()
    }
    
    func set_Cursol(){
        tableView.scrollToRow(at:[0, tableviewcount-1] , at: UITableView.ScrollPosition.top, animated: true)
        if  let cell: AddCategoryTableViewCell = tableView.cellForRow(at: [0, tableviewcount-1]) as? AddCategoryTableViewCell{
            cell.textField.becomeFirstResponder()
            }
    }
    
    func search(label: String){
        use_categorys = []
        let VC = parent as! CategoryViewController
        if label != ""{
        for value in categorys{
            if value.category.lowercased().contains(label){
                use_categorys.append(value.category)
            }
            VC.AddButton.isHidden = true
            
        }
        }
        else{
            for value in categorys{
                use_categorys.append(value.category)
            }
            VC.AddButton.isHidden = false
        }
        tableviewcount = use_categorys.count
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableviewcount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < use_categorys.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Category_selectCell", for: indexPath) as! Category_selectTableViewCell
            cell.Category_label.text = use_categorys[indexPath.row]
            if select_categorys.contains(use_categorys[indexPath.row]){
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.accessoryType = .checkmark
            }
            else{
                tableView.deselectRow(at: indexPath, animated: false)
                cell.accessoryType = .none
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCategoryCell", for: indexPath) as! AddCategoryTableViewCell
            cell.textField.delegate = self
            cell.textField.text = ""
            cell.selectionStyle = .none
            return cell
        }
        // Configure the cell...

    }
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        if let cell: Category_selectTableViewCell = tableView.cellForRow(at: indexPath) as? Category_selectTableViewCell{
            select_categorys.append((cell.Category_label.text)!)
            cell.accessoryType = .checkmark
            let VC = parent as! CategoryViewController
            VC.select_categorys = select_categorys
            }
        }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell: Category_selectTableViewCell = tableView.cellForRow(at: indexPath) as? Category_selectTableViewCell{
            select_categorys.removeAll(where: {$0 == (cell.Category_label.text)!})
            cell.accessoryType = .none
            let VC = parent as! CategoryViewController
            VC.select_categorys = select_categorys
            }
        }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension CategoryTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        if textField.text == ""{
            Category_delete()
        }
        else{
            Category_add(label: textField.text!)
        }
            return true
        }
}
