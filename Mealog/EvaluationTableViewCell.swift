//
//  EvaluationTableViewCell.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class EvaluationTableViewCell: UITableViewCell {

    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    var rate: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGR1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap_star1))
        tapGR1.cancelsTouchesInView = false
        star1.addGestureRecognizer(tapGR1)
        let tapGR2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap_star2))
        tapGR2.cancelsTouchesInView = false
        star2.addGestureRecognizer(tapGR2)
        let tapGR3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap_star3))
        tapGR3.cancelsTouchesInView = false
        star3.addGestureRecognizer(tapGR3)
        let tapGR4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap_star4))
        tapGR4.cancelsTouchesInView = false
        star4.addGestureRecognizer(tapGR4)
        let tapGR5: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap_star5))
        tapGR5.cancelsTouchesInView = false
        star5.addGestureRecognizer(tapGR5)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func tap_star1(){
        if rate != 1{
        star1.image = UIImage(systemName: "star.fill")
        star2.image = UIImage(systemName: "star")
        star3.image = UIImage(systemName: "star")
        star4.image = UIImage(systemName: "star")
        star5.image = UIImage(systemName: "star")
            rate = 1
        }
        else{
            rate_zero()
        }
    }
    
    @objc func tap_star2(){
        if rate != 2{
        star1.image = UIImage(systemName: "star.fill")
        star2.image = UIImage(systemName: "star.fill")
        star3.image = UIImage(systemName: "star")
        star4.image = UIImage(systemName: "star")
        star5.image = UIImage(systemName: "star")
        rate = 2
        }
        else{
            rate_zero()
        }
    }
    
    @objc func tap_star3(){
        if rate != 3{
        star1.image = UIImage(systemName: "star.fill")
        star2.image = UIImage(systemName: "star.fill")
        star3.image = UIImage(systemName: "star.fill")
        star4.image = UIImage(systemName: "star")
        star5.image = UIImage(systemName: "star")
        rate = 3
        }
        else{
            rate_zero()
        }
    }
    
    @objc func tap_star4(){
        if rate != 4{
        star1.image = UIImage(systemName: "star.fill")
        star2.image = UIImage(systemName: "star.fill")
        star3.image = UIImage(systemName: "star.fill")
        star4.image = UIImage(systemName: "star.fill")
        star5.image = UIImage(systemName: "star")
        rate = 4
        }
        else{
            rate_zero()
        }
    }
    
    @objc func tap_star5(){
        if rate != 5{
        star1.image = UIImage(systemName: "star.fill")
        star2.image = UIImage(systemName: "star.fill")
        star3.image = UIImage(systemName: "star.fill")
        star4.image = UIImage(systemName: "star.fill")
        star5.image = UIImage(systemName: "star.fill")
        rate = 5
        }
        else{
            rate_zero()
        }
    }
    
    func rate_zero(){
        star1.image = UIImage(systemName: "star")
        star2.image = UIImage(systemName: "star")
        star3.image = UIImage(systemName: "star")
        star4.image = UIImage(systemName: "star")
        star5.image = UIImage(systemName: "star")
        rate = 0
    }
}
