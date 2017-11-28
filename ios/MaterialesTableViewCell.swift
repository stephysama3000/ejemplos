//
//  MaterialesTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by redlinks on 12/10/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit

class MaterialesTableViewCell: UITableViewCell {

    @IBOutlet var bordeMateria: UIImageView!
    @IBOutlet var numMateriales: UILabel!
    @IBOutlet var materia: UILabel!
    @IBOutlet var iconMateria: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //btnFact.layer.masksToBounds = false
        bordeMateria.layer.cornerRadius = 8.0
        bordeMateria.layer.borderWidth = 2.0
        bordeMateria.layer.borderColor = UIColor(red:205/255.0, green:206/255.0, blue:211/255.0, alpha: 1.0).cgColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

