//
//  AgendaViewController.swift
//  SlideMenuControllerSwift
//
//  Created by redlinks on 18/12/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController{
    
    @IBOutlet var tableAgenda: UITableView!
    @IBOutlet weak var agendabox: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        agendabox.backgroundColor = UIColor(red: CGFloat(64.0/255.0), green: CGFloat(132.0/255.0), blue: CGFloat(185.0/255.0), alpha: 1.0)
    
        let navBarLineView = UIView(frame: CGRect(x: 0,
                                              y: (navigationController?.navigationBar.frame)!.height,
                                              width: (self.navigationController?.navigationBar.frame)!.width,
                                              height: 1))
    
        navBarLineView.backgroundColor = UIColor(red: CGFloat(64.0/255.0), green: CGFloat(132.0/255.0), blue: CGFloat(185.0/255.0), alpha: 1.0)
    
        navigationController?.navigationBar.addSubview(navBarLineView)
    }
}
