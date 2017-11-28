//
//  AgendaTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by redlinks on 4/1/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {

    @IBOutlet var tituloAgenda: UILabel!
    @IBOutlet var detalleAgenda: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
