//
//  SignupViewController.swift
//  VIP
//
//  Created by FCI on 18/12/24.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet var tf1 : UITextField!
    @IBOutlet var tf2 : UITextField!
    @IBOutlet var tf3 : UITextField!
    @IBOutlet var b1 : UIButton!
    @IBOutlet var dismissButton1 : UIButton!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func b1Click() {
        
    }
    @IBAction func dismissButton1Click() {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
