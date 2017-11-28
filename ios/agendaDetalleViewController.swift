//
//  agendaDetalleViewController.swift
//  SlideMenuControllerSwift
//
//  Created by redlinks on 12/1/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit

class agendaDetalleViewController: UIViewController {


    @IBOutlet weak var textoDetalleAgenda: UITextView!
    @IBOutlet var container: UIView!
    @IBOutlet var agendaDetalle: UILabel!
    @IBOutlet var agendaMateria: UILabel!
    @IBOutlet var agendaTitulo: UILabel!
    @IBOutlet var imagen: UIImageView!
    
    var titulosArray = [String]()
    var detalleArray = [String]()
    var profesorNomArray = [String]()
    var detalleMatArray = [String]()
    var imageUrlArray = [String]()
    var profesorCodiArray = [String]()
    var fechaIniArray = [String]()
    var fechaFinArray = [String]()
    var numero = 0
    var photo = UIImage(named: "ic_profile")!
    fileprivate var yConstraint: NSLayoutConstraint!
    fileprivate var xConstraint: NSLayoutConstraint!
    
    override func viewDidLayoutSubviews() {
        textoDetalleAgenda.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.imagen.layer.cornerRadius = self.imagen.frame.size.height / 2
        self.imagen.clipsToBounds = true
        self.imagen.layer.borderWidth = 3
        var orange = UIColor(red: CGFloat(229.0/255.0), green: CGFloat(90.0/255.0), blue: CGFloat(47.0/255.0), alpha: 1.0)

        self.imagen.layer.borderColor = orange.cgColor
            
        self.imagen.setRandomDownloadImage(80, height: 80)


        
        titulosArray = (UserDefaults.standard.object(forKey: "agendaTitulo")) as! [String]
        detalleArray = UserDefaults.standard.object(forKey: "agendaDetalle") as! [String]
        profesorNomArray = UserDefaults.standard.object(forKey: "agendaProfesorNom") as! [String]
        detalleMatArray = UserDefaults.standard.object(forKey: "detalleMateria") as! [String]
        imageUrlArray = UserDefaults.standard.object(forKey: "imageUrl") as! [String]
        profesorCodiArray = UserDefaults.standard.object(forKey: "agendaProfesorCodi") as! [String]
        fechaIniArray = UserDefaults.standard.object(forKey: "fechaIni") as! [String]
        fechaFinArray = UserDefaults.standard.object(forKey: "fechaFin") as! [String]
        numero = UserDefaults.standard.object(forKey: "agendaEscogido") as! Int
        //var readtitulosArray : [NSString] = titulosArray! as! [NSString]
        print(detalleArray)
        print(profesorNomArray)
        print(detalleMatArray)
        print(imageUrlArray)
        print(profesorCodiArray)
        print(fechaIniArray)
        print(fechaFinArray[0])
        print(numero)
        

        
        let url = URL(string: imageUrlArray[numero])
        var data = try? Data(contentsOf: url!)
        if data != nil {
            imagen.image = UIImage(data:data!)!
        }
        else{
            imagen.image = UIImage(named: "ic_profile")!
        }
        
        print(fechaIniArray[numero])
        print(fechaFinArray[numero])
        agendaMateria.text = detalleMatArray[numero]
        agendaTitulo.text = titulosArray[numero]
        textoDetalleAgenda.text = detalleArray[numero]
        //agendaprofesor.text = profesorNomArray[numero]
        
        //agendafechafin.text = fechaFinArray[numero]
        //agendafechaini.text = fechaIniArray[numero]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(string: textoDetalleAgenda.text!,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSBaselineOffsetAttributeName: NSNumber(value: 0 as Float)
            ])

        
        self.textoDetalleAgenda.layer.borderWidth = 2.3
        self.textoDetalleAgenda.layer.cornerRadius = 15
        
        textoDetalleAgenda.flashScrollIndicators()
        textoDetalleAgenda.showsVerticalScrollIndicator = true
        textoDetalleAgenda!.layer.borderWidth = 1
        textoDetalleAgenda!.layer.borderColor = orange.cgColor
        //textoDetalleAgenda.attributedText = attributedString
        
        
        agendaMateria!.sizeToFit()
        agendaMateria.lineBreakMode = NSLineBreakMode.byWordWrapping;
        agendaMateria.numberOfLines = 0;
        agendaMateria.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
        agendaMateria.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
        agendaMateria.translatesAutoresizingMaskIntoConstraints = false
  
        container.translatesAutoresizingMaskIntoConstraints = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
