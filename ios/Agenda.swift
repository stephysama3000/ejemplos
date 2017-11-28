//
//  Agenda.swift
//  SlideMenuControllerSwift
//
//  Created by redlinks on 4/1/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit

class Agenda{

    // MARK: Properties
    
    var tituloAgenda: String
    var detalleAgenda: String
    var imagenProfesor: UIImage?
    
    // MARK: Initialization
    
    init?(tituloAgenda: String, detalleAgenda: String, imagenProfesor: UIImage?) {
        // Initialize stored properties.
        self.tituloAgenda = tituloAgenda
        self.detalleAgenda = detalleAgenda
        self.imagenProfesor = imagenProfesor
        

    }

}
