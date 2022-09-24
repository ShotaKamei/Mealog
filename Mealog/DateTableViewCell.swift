//
//  DateTableViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet weak var DarePicker: UIDatePicker!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
