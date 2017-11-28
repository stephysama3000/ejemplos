//
//  FacturasTableViewController.swift
//  SlideMenuControllerSwift
//
//  Created by redlinks on 1/8/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NMPopUpViewSwift


class MaterialesTableViewController: UITableViewController {
    
    
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var labelNoMens: UILabel!
    @IBOutlet var descargarbtn: UIButton!
    
    var cursoCodiAlum : String = ""
    var colegio : String = ""
    var periodo : String = ""
    let defaults = UserDefaults.standard
    var URL : String = "http://demo.educalinks.com.ec/mobile/main.php"
    var nomCol : String = ""
    var numCol = 0
    
    var alumCursParaMateCodiA = [String]()
    var cursParaMateCodiA = [String]()
    var cursParaMateProfCodiA = [String]()
    var materiaCodiA = [Int]()
    var materiaDetalleA = [String]()
    var profNombreA = [String]()
    var profApellidoA = [String]()
    var materialesnumero = [Int]()
    var imagenes = [String]()
    var getImage : UIImage!
    var materiales = [Materiales]()
    

    var myStringArrIni = [String]()
    var FilaEscog:Int = 0
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        indicator.startAnimating()
        self.indicator.isHidden = false
        
        colegio = defaults.string(forKey: "colegio")!
        periodo = defaults.string(forKey: "periodo")!
        cursoCodiAlum = defaults.string(forKey: "alumCursCodi")!

        
        numCol = Int(colegio)!
        
        switch (numCol) {
        case 1:
            nomCol = "liceopanamericano";
            break;
        case 2:
            nomCol = "ecobab";
            break;
        case 5:
            nomCol = "moderna";
            break;
        case 11:
            nomCol = "ecobabvesp";
            break;
        case 12:
            nomCol = "desarrollo";
            break;
        case 16:
            nomCol = "delfos";
            break;
        case 17:
            nomCol = "delfosvesp";
            break;
        case 18:
            nomCol = "liceopanamericanosur";
            break;
        case 26:
            nomCol = "duplos";
            break;
        case 27:
            nomCol = "arcoiris";
            break;
        default:
            print("Su institución no se encuentra en el directorio")
        }
   
        
        let parameters = [
            "colegio": colegio,
            "opcion" : "clases_materias",
            "alumCursParaCodi" : cursoCodiAlum
        ]
        
        self.alumCursParaMateCodiA.removeAll()
        self.cursParaMateCodiA.removeAll()
        self.cursParaMateProfCodiA.removeAll()
        self.materiaCodiA.removeAll()
        self.materiaDetalleA.removeAll()
        self.profNombreA.removeAll()
        self.profApellidoA.removeAll()
        self.materialesnumero.removeAll()
        self.imagenes.removeAll()

        
        Alamofire.request(URL , method: .post,  parameters: parameters).responseJSON { response in
            
            let JSON1 = response.result.value as! NSDictionary
            if(JSON1 != nil){
                var result = JSON1.value(forKey: "result") as! NSArray
                self.materiales.removeAll()
                if(result.count>0){
                    self.materiales.removeAll()
                    for i in 0..<result.count{
                        let valor = result[i] as! NSDictionary
                        
                        let alumCursParaMateCodi = valor.value(forKey:"alumCursParaMateCodi")
                        let cursParaMateCodi = valor.value(forKey:"cursParaMateCodi")
                        let cursParaMateProfCodi = valor.value(forKey:"cursParaMateProfCodi")
                        let materiaCodi = valor.value(forKey:"materiaCodi")
                        let materiaDetalle = valor.value(forKey:"materiaDetalle")
                        let profNombre = valor.value(forKey:"profNombre")
                        let profApellido = valor.value(forKey:"profApellido")
                        let materialesnumeroS = valor.value(forKey:"materCount")
                        
                        self.alumCursParaMateCodiA.append(alumCursParaMateCodi! as! String)
                        self.cursParaMateCodiA.append(cursParaMateCodi! as! String)
                        self.cursParaMateProfCodiA.append(cursParaMateProfCodi! as! String)
                        self.materiaCodiA.append(materiaCodi! as! Int)
                        self.materiaDetalleA.append(materiaDetalle! as! String)
                        self.profNombreA.append(profNombre! as! String)
                        self.profApellidoA.append(profApellido! as! String)
                        self.materialesnumero.append(materialesnumeroS! as! Int)
                        
                        var a = "http://" + self.nomCol + ".educalinks.com.ec/iconos/"
                        var b = self.nomCol + "/" + self.periodo + "/"
                        var c = String(self.materiaCodiA[i]) + ".png"
                        self.imagenes.append(a + b + c)
                        
                        let url = Foundation.URL(string: self.imagenes[i])
                        var data = try? Data(contentsOf: url!)
                        //print(url)
                        //print(data)
                        
                        if data != nil {
                             self.getImage = UIImage(data: data!)
                            //self.imageAlumno?.image = getImage
                        }
                        else{
                             self.getImage = UIImage(named: "defaultclase")
                            //self.imageAlumno?.image = getImage
                        }

                        
                        
                        let material = Materiales(materia: self.materiaDetalleA[i].uppercased(),numMateriales:self.materialesnumero[i], imagen: self.getImage)!
                        self.materiales += [material]
                        
                    }
                    self.tableView.reloadData()
                    var defaults = UserDefaults.standard
                    self.defaults.set(self.alumCursParaMateCodiA, forKey: "alumCursParaMateCodiA")
                    self.defaults.set(self.cursParaMateCodiA, forKey: "cursParaMateCodiA")
                    self.defaults.set(self.cursParaMateProfCodiA, forKey: "cursParaMateProfCodiA")
                    self.defaults.set(self.materiaCodiA, forKey: "materiaCodiA")
                    self.defaults.set(self.materiaDetalleA, forKey: "materiaDetalleA")
                    self.defaults.set(self.profNombreA, forKey: "profNombreA")
                    self.defaults.set(self.profApellidoA, forKey: "profApellidoA")
                    self.defaults.set(self.materialesnumero, forKey: "materialesnumero")
                    self.defaults.set(self.imagenes, forKey: "imagenes")
                    
                }else{
                    self.labelNoMens.isHidden = false
                    self.alumCursParaMateCodiA.removeAll()
                    self.cursParaMateCodiA.removeAll()
                    self.cursParaMateProfCodiA.removeAll()
                    self.materiaCodiA.removeAll()
                    self.materiaDetalleA.removeAll()
                    self.profNombreA.removeAll()
                    self.profApellidoA.removeAll()
                    self.materialesnumero.removeAll()
                    self.imagenes.removeAll()
                    self.tableView.reloadData()
                }
            }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var contador = materiales.count
        return materiales.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MaterialesTableViewCell?
        let cellIdentifier = "MaterialesTableViewCell"
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MaterialesTableViewCell
        /*if (indexPath as NSIndexPath).row % 2 == 0 {
            cell!.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            
        }
        else {
            cell!.backgroundColor = UIColor(red: 65/255, green: 190/255, blue: 220/255, alpha: 0.2)
        }*/
        

        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        
        let line = materiales[(indexPath as NSIndexPath).row]
        cell!.materia.text = line.materia
        cell!.numMateriales.text = String(line.numMateriales)
        cell!.iconMateria.image = line.imagen

        FilaEscog = (indexPath as NSIndexPath).row
        return cell!
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "materialesDetalle", sender: self)
        defaults.set((indexPath as NSIndexPath).row, forKey: "materialEscogido")
        defaults.set(self.profNombreA[indexPath.row], forKey: "nombreProfEscogido")
        defaults.set(self.imagenes[indexPath.row], forKey: "imagenEscogido")
        defaults.set(self.profApellidoA[indexPath.row], forKey: "apelProfEscogido")
        defaults.set(self.cursParaMateProfCodiA[indexPath.row], forKey: "cursParaMateProfCodiEscogido")
        defaults.set(self.materiaDetalleA[indexPath.row], forKey: "materiaDetalleEscogido")
        
    }

    
    /*func showAlertForRow(row: Int) {
     let alert = UIAlertController(
     title: "BEHOLD",
     message: "Cell at row \(row) was tapped!",
     preferredStyle: .Alert)
     alert.addAction(UIAlertAction(title: "Gotcha!", style: UIAlertActionStyle.Default, handler: { (test) -> Void in
     self.dismissViewControllerAnimated(true, completion: nil)
     }))
     
     self.presentViewController(
     alert,
     animated: true,
     completion: nil)
     }*/
    
    
    /*func buttonClicked(_ sender:UIButton) {
        let buttonRow = sender.tag
        let URL: String = URLdesc[FilaEscog]
        if UIApplication.shared.canOpenURL(Foundation.URL(string: URL)!) {
            UIApplication.shared.openURL(Foundation.URL(string: URL)!)
        }
        else {
            self.displayAlert("Error", error: "No existe la ruta especificada")
            
        }
        
    }
    
    func displayAlert(_ title:String, error:String) {
        let alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }*/
    

}
