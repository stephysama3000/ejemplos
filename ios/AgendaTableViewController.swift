//
//  AgendaTableViewController.swift
//  SlideMenuControllerSwift
//
//  Created by redlinks on 4/1/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NMPopUpViewSwift

class AgendaTableViewController: UITableViewController {

    // MARK: Properties
    var popViewController : PopUpViewControllerSwift!
    let defaults = UserDefaults.standard
    var colegio : String = ""
    var alumnocodi : String = ""
    var reprcodigo : String = ""
    var periodo : String = ""
    var usuario : String = ""
    var password : String = ""
    var nomCol : String = ""
    var fechaAgenda : String = ""
    var numCol = 0
    var imageUrl = [String]()
    var photo = UIImage(named: "ic_profile")!
    var agendaTitulo = [String]()
    var agendaDetalle = [String]()
    var fecIni = [String]()
    var fecFin = [String]()
    var profesorCodi = [String]()
    var profesorNombre = [String]()
    var agendaDetMateria = [String]()
    var myStringArrIni = [String]()
    var myStringArrFin = [String]()
    var inicio = [String]()
    var fin = [String]()
    var cnt = 0
    var agenda = [Agenda]()
    var URL : String = "http://demo.educalinks.com.ec/mobile/main.php"
    
    @IBOutlet weak var labelNoagenda: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(64.0/255.0), green: CGFloat(132.0/255.0), blue: CGFloat(185.0/255.0), alpha: 1.0)


        let navBarLineView = UIView(frame: CGRect(x: 0,
            y: (navigationController?.navigationBar.frame)!.height,
            width: (self.navigationController?.navigationBar.frame)!.width,
            height: 1))
        
        navBarLineView.backgroundColor = UIColor(red: CGFloat(64.0/255.0), green: CGFloat(132.0/255.0), blue: CGFloat(185.0/255.0), alpha: 1.0)
        
        navigationController?.navigationBar.addSubview(navBarLineView)
        
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        alumnocodi = defaults.string(forKey: "codigoAlumno")!
        reprcodigo = defaults.string(forKey: "codigo")!
        periodo = defaults.string(forKey: "periodo")!
        colegio = defaults.string(forKey: "colegio")!
        usuario = defaults.string(forKey: "usuario")!
        password = defaults.string(forKey: "password")!
        
        //nombres = lowercaseDestination(nombres)
        //apellidos = lowercaseDestination(apellidos)
        //labelPicker.text = nombres + " " + apellidos
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
            "usuario" : usuario,
            "password" : password,
            "tipo_usua" : "2",
            "opcion" : "mostrar_agenda",
            "reprcodi" : reprcodigo,
            "pericodi" : periodo,
            "alumnocodi" : alumnocodi
        ]
        
        //listar alumnos en spinner
        
        self.agendaTitulo.removeAll()
        self.agendaDetalle.removeAll()
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON { response in
            
            
            let JSON1 = response.result.value as! NSDictionary
            if(JSON1 != nil){
                var result = JSON1.value(forKey: "result") as! NSArray
                self.agenda.removeAll()
                if(result.count>0){
                    self.agenda.removeAll()
                    self.labelNoagenda.isHidden = true
                    
                    for i in 0..<result.count{
                        let valor = result[i] as! NSDictionary
                        var tituloAgenda = valor.value(forKey:"tituloAgenda")
                        var detalleAgenda = valor.value(forKey:"detalleAgenda")
                        var detalleMateria = valor.value(forKey:"detalleMateria")
                        var nombreProfesor = valor.value(forKey:"nombreProfesor")
                        var profcodi = valor.value(forKey:"profcodi") as AnyObject? as? Int
                        var str = String(profcodi!)
                        var fechaIniAgenda = valor.value(forKey:"fechaIniAgenda") as! NSDictionary
                        var ini = fechaIniAgenda.value(forKey: "date")!
                        self.myStringArrIni = (ini as AnyObject).components(separatedBy: " ")
                        self.inicio.append(self.myStringArrIni[0])
                        
                        let fechaFinAgenda = valor.value(forKey:"fechaFinAgenda")as! NSDictionary
                        let fin = fechaFinAgenda.value(forKey:"date")!
                        self.myStringArrFin = (fin as AnyObject).components(separatedBy: " ")
                        self.fin.append(self.myStringArrFin[0])
                        
                        
                        self.agendaTitulo.append(tituloAgenda! as! String)
                        self.agendaDetalle.append(detalleAgenda! as! String)
                        self.profesorCodi.append(str)
                        self.profesorNombre.append(nombreProfesor! as! String)
                        self.agendaDetMateria.append(detalleMateria! as! String)
                        self.imageUrl.append("http://demo.educalinks.com.ec/fotos/" + self.nomCol + "/docentes/" + self.profesorCodi[i] + ".jpg")
                        
                        
                        
                        let agendas = Agenda(tituloAgenda: self.agendaTitulo[i].uppercased(),detalleAgenda:self.agendaDetalle[i], imagenProfesor: self.photo)!
                        self.agenda += [agendas]
                        
                        
                        
                    }
                    self.tableView.reloadData()
                    
                    var defaults = UserDefaults.standard
                    defaults.set(self.agendaTitulo, forKey: "agendaTitulo")
                    defaults.set(self.agendaDetalle, forKey: "agendaDetalle")
                    defaults.set(self.profesorNombre, forKey: "agendaProfesorNom")
                    defaults.set(self.agendaDetMateria, forKey: "detalleMateria")
                    defaults.set(self.imageUrl, forKey: "imageUrl")
                    defaults.set(self.profesorCodi, forKey: "agendaProfesorCodi")
                    defaults.set(self.inicio, forKey: "fechaIni")
                    defaults.set(self.fin, forKey: "fechaFin")
                    
                }else{
                    self.labelNoagenda.isHidden = false
                    self.agendaTitulo.removeAll()
                    self.agendaDetalle.removeAll()
                    self.tableView.reloadData()
                }
            }
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
        }

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return agenda.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AgendaTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AgendaTableViewCell
       if (indexPath as NSIndexPath).row % 2 == 0 {
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        }
        else {
            cell.backgroundColor = UIColor(red: 230/255, green: 231/255, blue: 232/255, alpha: 1)
        }

            let line = agenda[(indexPath as NSIndexPath).row]
            cell.tituloAgenda.text = line.tituloAgenda
            cell.detalleAgenda.text = line.detalleAgenda
            cnt = cnt+1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "agendaDetalle", sender: self)
        defaults.set((indexPath as NSIndexPath).row, forKey: "agendaEscogido")
        
    }
    

    

}
