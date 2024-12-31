//
//  menuViewController.swift
//  Insurance
//
//  Created by FCI on 25/12/24.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet var textField: UITextField!
    @IBOutlet var img: UIImageView!
}

class menuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var menubtn: UIButton!
    
    var customerValues: [String] = [] // Array of values to display in the table view

    @IBOutlet var textlist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Received customer values: \(customerValues)")
        
        // Set the delegate and data source for the table view
        textlist.delegate = self
        textlist.dataSource = self
    }
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "id1", for: indexPath) as? CustomCell else {
            fatalError("Failed to dequeue cell with identifier 'id1'")
        }
        
        // Populate the text field with customer value
        cell.textField.text = customerValues[indexPath.row]
        
        // Assign appropriate SF Symbol to the image based on the index
        switch indexPath.row {
        case 0:
            cell.img.image = UIImage(systemName: "person.fill") // Customer ID symbol
        case 1:
            cell.img.image = UIImage(systemName: "character.textbox") // Customer Name symbol
        case 2:
            cell.img.image = UIImage(systemName: "phone.fill") // Phone symbol
        case 3:
            cell.img.image = UIImage(systemName: "envelope.fill") // Email symbol
        case 4:
            cell.img.image = UIImage(systemName: "house.fill") // Address symbol
        default:
            cell.img.image = nil // Default case if none matches
        }
        
        return cell
    }
    
    // MARK: - Table View Header
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Profile Menu"
    }
    
    // MARK: - Toggle Table View Visibility
    
    @IBAction func clickShowHide(_ sender: UIButton) {
        // Toggle the visibility of the table view
        textlist.isHidden.toggle()
    }
}
