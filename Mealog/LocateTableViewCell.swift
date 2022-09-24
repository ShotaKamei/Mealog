//
//  LocateTableViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class LocateTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dismissKeyboard(){
        textField.endEditing(true)
    }
    
}
extension LocateTableViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            textField.resignFirstResponder()
            return true
        }
}
