//
//  PharmacyTableViewCell.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 23.01.2023.
//

import UIKit

class PharmacyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var telButton: UIButton!
    @IBOutlet weak var adresLabel: UILabel!
    @IBOutlet weak var ilceLabel: UILabel!
    @IBOutlet weak var eczaneAdiLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
