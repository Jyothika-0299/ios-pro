//
//  ProfileViewController.swift
//  Insurance
//
//  Created by FCI on 24/12/24.
//

//
//  ViewController.swift
//  Insurance
//
//  Created by FCI on 24/12/24.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet var tableview : UITableView!
    //@IBOutlet var image : UIImageView!
    // Defining sections along with row data
    //section 1 :
    var Section1Names : [String] = ["ID","Name", "Email","Phoneno", "Address"]
    let sectionTitles = ["Profile"]
    let sectionImages = ["pup.jpeg"]
    
    var section1Inputs: [String] = Array(repeating: "", count: 5)
    
    var CustomerID: String?
    var CustomerName: String?
    var CustomerEmail: String?
    var CustomerPhone: String?
    var CustomerAddress: String?
    
    @IBOutlet var l1 : UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        section1Inputs[0] = CustomerID ?? ""
        section1Inputs[1] = CustomerName ?? ""
        section1Inputs[2] = CustomerEmail ?? ""
        section1Inputs[3] = CustomerPhone ?? ""
        section1Inputs[4] = CustomerAddress ?? ""
        
        tableview.delegate = self
        tableview.dataSource = self
        /*
        if let CustomerID = CustomerID {
                    section1Inputs[0] = CustomerID
                }
        if let CustomerName = CustomerName {
                    section1Inputs[1] = CustomerName
                }
        if let CustomerEmail = CustomerEmail {
                    section1Inputs[2] = CustomerEmail
                }
        if let CustomerPhone = CustomerPhone {
                    section1Inputs[3] = CustomerPhone
                }
        if let CustomerAddress = CustomerAddress {
                    section1Inputs[4] = CustomerAddress
                }
        */
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //2.number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return Section1Names.count
            
        
    }
    
    //3.title for header section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
                headerView.backgroundColor = .lightGray
                
                // Add an image view
                let imageView = UIImageView()
                imageView.image = UIImage(named: sectionImages[section]) // Replace with your image names
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                
                // Add a label
                let titleLabel = UILabel()
                titleLabel.text = sectionTitles[section]
                titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
                titleLabel.textColor = .black
                titleLabel.textAlignment = .left
                
                // Add subviews to headerView
                headerView.addSubview(imageView)
                headerView.addSubview(titleLabel)
        // Set constraints for the image view
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                    imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 40),
                    imageView.heightAnchor.constraint(equalToConstant: 40)
                ])
                
                // Set constraints for the label
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                    titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10)
                ])
        return headerView
        
                
        
    }
    
    /*//4.title for footer section
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {

            return "Bike Insurance Products End"
        }
    }*/
    //5.display the info in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
               
               // Configure the label
               let label = UILabel()
               label.text =  Section1Names[indexPath.row]
               label.font = UIFont.systemFont(ofSize: 16)
               label.textColor = .black
               
               // Configure the text field
               let textField = UITextField()
               textField.borderStyle = .roundedRect
               textField.placeholder = "Enter \(label.text!)"
               textField.delegate = self
               textField.tag = indexPath.section * 100 + indexPath.row // Unique tag to identify the text field
               
               // Pre-fill text field if data exists
               if indexPath.section == 0 {
                   textField.text = section1Inputs[indexPath.row]
    
               }
               
               // Add label and text field to the cell
               cell.contentView.addSubview(label)
               cell.contentView.addSubview(textField)
               
               // Layout constraints
               label.translatesAutoresizingMaskIntoConstraints = false
               textField.translatesAutoresizingMaskIntoConstraints = false
               
               NSLayoutConstraint.activate([
                   label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
                   label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                   label.widthAnchor.constraint(equalToConstant: 100),
                   
                   textField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
                   textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
                   textField.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                   textField.heightAnchor.constraint(equalToConstant: 30)
               ])
               
               return cell
           }
           
        
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        let section = textField.tag / 100
        let row = textField.tag % 100
        
        if section == 0 {
            section1Inputs[row] = textField.text ?? ""
        }
    }
  
    //6.height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //7.height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    /*
    func setCustomerData(id: String, name: String, email: String, phone: String, address: String) {
        self.CustomerID = id
        self.CustomerName = name
        self.CustomerEmail = email
        self.CustomerPhone = phone
        self.CustomerAddress = address
        }*/
    
    /*
    //8.whe user select any row in tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Ins_Name.text = Section1Names[indexPath.row]
            //image.image = UIImage(named: Section1Images[indexPath.row])
        
    
        } else {
            Ins_Name.text = Section2Names[indexPath.row]
            //image.image = UIImage(named: Section2Images[indexPath.row])
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
        let indexTitles = ["Profile","Sign out"]
        return indexTitles
     
    }*/
    
    
    
    
    


}

