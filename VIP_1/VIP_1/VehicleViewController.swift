//
//  VehicleViewController.swift
//  VIP_1
//
//  Created by FCI on 23/12/24.
//



// Imports the framework, which provides the necessary infrastructure for iOS apps.
import UIKit
import QuartzCore

// Defines a ViewController class that manages the app's user interface.
class VehicleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Connects below different UIObjects from the storyboard to this code.
    @IBOutlet var tableView : UITableView!
    //@IBOutlet var image : UIImageView!
    @IBOutlet var Ins_Name : UILabel!
    @IBOutlet var Vehicle_Name : UILabel!
    @IBOutlet var NextButton : UIButton!
    //core animation
    var labelLayer : CALayer!
    var Button : CALayer!
    var imageviewLayer : CALayer!
    var screenviewLayer : CALayer!
    

    // Defining sections along with row data
    //section 1 :
    var Section1Names : [String] = ["Third party legal liability", "Comprehensive insurance", "Own damage coverage"]
    //section 2 :
    var Section2Names : [String] = ["Third party legal liability", "Comprehensive insurance", "Own damage coverage"]

    
    
    
    // Called when the view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //core animation for webname label
        labelLayer = Ins_Name.layer
        labelLayer.borderColor = UIColor.black.cgColor
        labelLayer.borderWidth = 2
        labelLayer.cornerRadius = 5
        //labelLayer.backgroundColor = UIColor.purple.cgColor
        
        //core animation for next button
        Button = NextButton.layer
        Button.borderColor = UIColor.black.cgColor
        Button.borderWidth = 2
        Button.cornerRadius = 5
        //Button.backgroundColor = UIColor.yellow.cgColor
        //core animation for screen view layer
        screenviewLayer = self.view.layer
        //screenviewLayer.borderColor = UIColor.systemPink.cgColor
        //screenviewLayer.borderWidth = 10
        screenviewLayer.cornerRadius = 50
        
        // Do any additional setup after loading the view.
        if tableView == nil {
            print("tableView is nil. Check storyboard connections.")
        } else {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    //tableview protocol methods implementation
    //1.number of sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    //2.number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Section1Names.count
        } else {
            return Section2Names.count
        }
    }
    
    //3.title for header section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Vehicle Details"
        } else {
            return "Bike Insurance Products"
        }
        
    }
    
    //4.title for footer section
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Vehicle Details End"
        } else {
            return "Bike Insurance Products End"
        }
    }
    //5.display the info in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = Section1Names[indexPath.row]
        } else {
            cell.textLabel?.text = Section2Names[indexPath.row]
        }
        cell.accessoryType = .detailDisclosureButton
        //cell.backgroundColor = .clear
        cell.tintColor = .black
        return cell
        
    }
    //6.height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //7.height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    //8.whe user select any row in tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Ins_Name.text = Section1Names[indexPath.row]
            
        
    
        } else {
            Ins_Name.text = Section2Names[indexPath.row]
            
        }
        
    }
    //09.when user select any accesory detail button
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if indexPath.section == 0 {
            Ins_Name.text = Section1Names[indexPath.row]
           
       
       
        }
        else {
            Ins_Name.text = Section2Names[indexPath.row]
          
        }
        
    }
    //10.section index titles
    func sectionIndexTitles(for tableView : UITableView) -> [String]? {
        let indexTitles = ["Vehicle Details","Bike Insurance Products"]
        return indexTitles
    }
    
    
    
    // Defines an action triggered when the button is tapped.
    @IBAction func NextButtonClick() {
       
    }
    
    //tableview animation
    override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
            self.animateTable()
        }
        
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
       for i in cells {
         let cell: UITableViewCell = i as UITableViewCell
          cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
      }
       var index = 0
       for a in cells {
        let cell: UITableViewCell = a as UITableViewCell
           UIView.animate(withDuration: 1.5, delay: 0.09 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .allowAnimatedContent,
       animations: {
         cell.transform = CGAffineTransform(translationX: 0, y: 0);
       }, completion: nil)
       
       index += 1 }
      }
    
    
}

