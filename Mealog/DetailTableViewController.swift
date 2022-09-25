//
//  DetailTableViewController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var images: Array<UIImage>!
    var VC: CategoryViewController!
    var select_category: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CaptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CaptionCell")
        tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateCell")
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        tableView.register(UINib(nibName: "EvaluationTableViewCell", bundle: nil), forCellReuseIdentifier: "EvaluationCell")
        tableView.register(UINib(nibName: "LocateTableViewCell", bundle: nil), forCellReuseIdentifier: "LocateCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CaptionCell", for: indexPath) as! CaptionTableViewCell
            cell.images = images
            cell.selectionStyle = .none
            let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGR.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tapGR)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTableViewCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EvaluationCell", for: indexPath) as! EvaluationTableViewCell
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocateCell", for: indexPath) as! LocateTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CaptionCell", for: indexPath) as! CaptionTableViewCell
            return cell
        }

        // Configure the cell...

    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            performSegue(withIdentifier: "CategorySegue", sender: nil)
        }
    }
    @objc func dismissKeyboard(){
        if  let cell1: CaptionTableViewCell = tableView.cellForRow(at: [0, 0]) as? CaptionTableViewCell{
            cell1.dismissKeyboard()}
        if let cell2: LocateTableViewCell = tableView.cellForRow(at: [0, 4]) as? LocateTableViewCell{
            cell2.dismissKeyboard()}
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategorySegue" {
            VC = segue.destination as? CategoryViewController
            VC?.presentationController!.delegate = self
            VC.select_categorys = select_category
            if let sheets = VC.sheetPresentationController{sheets.detents = [.medium()]}
        }
      }

}
extension DetailTableViewController: UIAdaptivePresentationControllerDelegate {
    // このメソッドを実装
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // Modal画面から戻った際の画面の更新処理を行う。 (collectionView.reloadDataなど。)
        select_category = VC.select_categorys
        
    }
}
