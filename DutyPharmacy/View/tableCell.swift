//
//  Cell.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 20.01.2023.
//

import UIKit
class tableCell: UITableViewCell {
    
    @IBOutlet weak var telButton: UIButton!
    @IBOutlet weak var adresLabel: UILabel!
    @IBOutlet weak var ilceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var eczaneAdiLabel: UILabel!
    
    @IBOutlet weak var telNoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        telNoLabel.isHidden = true
   
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func telClickked(_ sender: Any) {

       if let url = URL(string: "tel://\(telNoLabel.text!)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
