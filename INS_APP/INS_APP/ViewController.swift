//
//  ViewController.swift
//  INS_APP
//
//  Created by FCI on 29/12/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var Image1 : UIImageView!
    @IBOutlet var Label1 : UILabel!
    @IBOutlet var Label2 : UILabel!
    @IBOutlet var Label3 : UILabel!
    @IBOutlet var Label4 : UILabel!
    @IBOutlet var Label5 : UILabel!
    @IBOutlet var addbutton : UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /*
    @IBAction func pv1Click() {
        let index:Int = pv1.currentPage
        if index == 0 {
            Image2.image = UIImage(named: "car_INS.jpeg")
        }
        else if index == 1 {
            Image2.image = UIImage(named: "car_INS.jpeg")
        }
        else {
            Image2.image = UIImage(named: "car_INS.jpeg")
        }
    }
     */
    @IBAction func addbuttonClick() {
        let NC = Veh1ViewController()
        navigationController?.pushViewController(NC, animated: true)
    }

}

