//
//  VehicleViewController.swift
//  Insurance
//
//  Created by FCI on 26/12/24.
//


/*
import UIKit

class VehicleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet var tableview : UITableView!
    @IBOutlet var Save : UIButton!
    // Defining sections along with row data
    //section 1 :
    var Section1Names : [String] = ["RegNo","RegAuthority", "OwnerID","Make", "Model","FuelType","Variant","Engineno","ChassisNo","EngineCapacity","SeatingCapacity","MfgYear","RegDate","BodyType","LeasedBy"]
    let sectionTitles = ["Vehicle Details"]
    let sectionImages = ["pup.jpeg"]
    
    var section1Inputs: [String] = Array(repeating: "", count: 5)
    /*
    var CustomerID: String?
    var CustomerName: String?
    var CustomerEmail: String?
    var CustomerPhone: String?
    var CustomerAddress: String?
    */


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        section1Inputs[0] = CustomerID ?? ""
        section1Inputs[1] = CustomerName ?? ""
        section1Inputs[2] = CustomerEmail ?? ""
        section1Inputs[3] = CustomerPhone ?? ""
        section1Inputs[4] = CustomerAddress ?? ""
        */
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
        if section == 0 {
            return "Profile End"
        } else {
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
    
    @IBAction func SaveClick() {
 /*
                let rno = regNoTextField.text ?? ""
                let make = makeTextField.text ?? ""
                let model = modelTextField.text ?? ""
                let variant = variantTextField.text ?? ""
                let engineNo = engineNoTextField.text ?? ""
                let chassisNo = chassisNoTextField.text ?? ""
                let engineCapacity = engineCapacityTextField.text ?? ""
                let regAuthority  = regAuthorityTextField.text ?? ""
                let ownerID = ownerIDTextField.text ?? ""
                let fuelType = fuelTypeTextField.text ?? ""
                let seatingCapacity = seatingCapacityTextField.text ?? ""
                let mfgYear = mfgYearTextField.text ?? ""
                let regDate = regDateTextField.text ?? ""
                let bodyType = bodyTypeTextField.text ?? ""
                let leasedBy = leasedByTextField.text ?? ""
  */
        
        guard let webserviceURL = URL(string: "https://abzcustomerwebapi-hana.azurewebsites.net/api/Customer") else {
                    self.showAlert(title: "Error", message: "Invalid service URL.")
                    return
                }
                
                var request = URLRequest(url: webserviceURL)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let customerData: [String: Any] = [
                    "CustomerID": ID,
                    "CustomerName": Name,
                    "CustomerPhone": Phone,
                    "CustomerEmail": Email,
                    "CustomerAddress": Address
                ]
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: customerData, options: [])
                    request.httpBody = jsonData
                } catch {
                    self.showAlert(title: "Error", message: "Failed to serialize JSON: \(error.localizedDescription)")
                    return
                }
                
                let session = URLSession.shared
                session.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self.showAlert(title: "Error", message: "Failed to save customer: \(error.localizedDescription)")
                            return
                        }
                        
                        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                            self.showAlert(title: "Error", message: "Server error: \(httpResponse.statusCode)")
                            return
                        }
                        
                        self.showAlert(title: "Success", message: "Customer saved successfully!")
                       
                    }
                }.resume()
    }
    private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    
    
    


}
*/


import UIKit

class VehicleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Outlets
    //@IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var regNoTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var variantTextField: UITextField!
    @IBOutlet weak var engineNoTextField: UITextField!
    @IBOutlet weak var chassisNoTextField: UITextField!
    @IBOutlet weak var engineCapacityTextField: UITextField!
    @IBOutlet weak var regAuthorityTextField: UITextField!
    @IBOutlet weak var ownerIDTextField: UITextField!
    @IBOutlet weak var fuelTypeTextField: UITextField!
    @IBOutlet weak var seatingCapacityTextField: UITextField!
    @IBOutlet weak var mfgYearTextField: UITextField!
    @IBOutlet weak var bodyTypeTextField: UITextField!
    @IBOutlet weak var leasedByTextField: UITextField!
    @IBOutlet weak var regDateTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var UpdateButton : UIButton!
    @IBOutlet weak var GetButton : UIButton!
    

    // MARK: - Properties
    private let regAuthorityPicker = UIPickerView()
    private let ownerIDPicker = UIPickerView()
    private let fuelTypePicker = UIPickerView()
    private let seatingCapacityPicker = UIPickerView()
    private let mfgYearPicker = UIPickerView()
    private let bodyTypePicker = UIPickerView()
    private let leasedByPicker = UIPickerView()
    private let datePicker = UIDatePicker()
    
    private let fuelTypes = ["P", "D", "E", "L", "G"]
    private let bodyTypes = ["Sedan", "SUV", "Hatchback", "MUV", "Van"]
    private let seatingCapacityRange = Array(1...9)
    private let yearRange = Array((Calendar.current.component(.year, from: Date()) - 50)...Calendar.current.component(.year, from: Date()))
    private let regAuthorities = ["AP", "TS", "KN"]
    private let ownerIDs = ["CUS01", "REP02", "JIP09"]
    private let lessees = ["HI", "KL", "AU"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickers()
        setupDatePicker()
        setupKeyboardDismissal()
    }
    
    // MARK: - Picker Setup
    private func setupPickers() {
        let pickers = [
            (regAuthorityPicker, regAuthorityTextField, regAuthorities),
            (ownerIDPicker, ownerIDTextField, ownerIDs),
            (fuelTypePicker, fuelTypeTextField, fuelTypes),
            (seatingCapacityPicker, seatingCapacityTextField, seatingCapacityRange.map { String($0) }),
            (mfgYearPicker, mfgYearTextField, yearRange.map { String($0) }),
            (bodyTypePicker, bodyTypeTextField, bodyTypes),
            (leasedByPicker, leasedByTextField, lessees)
        ]
        
        for (picker, textField, _) in pickers {
            picker.delegate = self
            picker.dataSource = self
            textField?.inputView = picker
            setupToolbar(for: textField!)
        }
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        regDateTextField.inputView = datePicker
        setupToolbar(for: regDateTextField)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    private func setupToolbar(for textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(toolbarDoneTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpace, doneButton]
        textField.inputAccessoryView = toolbar
    }
    
    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
   
    
    @objc private func toolbarDoneTapped() {
        view.endEditing(true)
        
    }
    
    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        regDateTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - UIPickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case regAuthorityPicker: return regAuthorities.count
        case ownerIDPicker: return ownerIDs.count
        case fuelTypePicker: return fuelTypes.count
        case seatingCapacityPicker: return seatingCapacityRange.count
        case mfgYearPicker: return yearRange.count
        case bodyTypePicker: return bodyTypes.count
        case leasedByPicker: return lessees.count
        default: return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch pickerView {
            case regAuthorityPicker:
                return regAuthorities[row]
            case ownerIDPicker:
                return ownerIDs[row]
            case fuelTypePicker:
                return fuelTypes[row]
            case seatingCapacityPicker:
                return String(seatingCapacityRange[row])
            case mfgYearPicker:
                return String(yearRange[row])
            case bodyTypePicker:
                return bodyTypes[row]
            case leasedByPicker:
                return lessees[row]
            default:
                return nil
            }
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case regAuthorityPicker:
            regAuthorityTextField.text = regAuthorities[row]
        case ownerIDPicker:
            ownerIDTextField.text = ownerIDs[row]
        case fuelTypePicker:
            fuelTypeTextField.text = fuelTypes[row]
        case seatingCapacityPicker:
            seatingCapacityTextField.text = String(seatingCapacityRange[row])
        case mfgYearPicker:
            mfgYearTextField.text = String(yearRange[row])
        case bodyTypePicker:
            bodyTypeTextField.text = bodyTypes[row]
        case leasedByPicker:
            leasedByTextField.text = lessees[row]
        default:
            break
        }
    }


    // MARK: - Actions
@IBAction func submitButtonClick() {
    
    /*
        // Collect form data
        let formData = [
            "regNo": regNoTextField.text,
            "make": makeTextField.text,
            "model": modelTextField.text,
            "variant": variantTextField.text,
            "engineNo": engineNoTextField.text,
            "chassisNo": chassisNoTextField.text,
            "engineCapacity": engineCapacityTextField.text,
            "regAuthority": regAuthorityTextField.text,
            "ownerID": ownerIDTextField.text,
            "fuelType": fuelTypeTextField.text,
            "seatingCapacity": seatingCapacityTextField.text,
            "mfgYear": mfgYearTextField.text,
            "regDate": regDateTextField.text,
            "bodyType": bodyTypeTextField.text,
            "leasedBy": leasedByTextField.text
        ]
        
        // Handle form submission
        print("Form Data:", formData)
     */
        
        let NO = regNoTextField.text ?? ""
        let regAuthority  = regAuthorityTextField.text ?? ""
        let make = makeTextField.text ?? ""
        let model = modelTextField.text ?? ""
        let fuelType = fuelTypeTextField.text ?? ""
        let variant = variantTextField.text ?? ""
        let engineNo = engineNoTextField.text ?? ""
        let chassisNo = chassisNoTextField.text ?? ""
        let engineCapacity = engineCapacityTextField.text ?? ""
        let seatingCapacity = seatingCapacityTextField.text ?? ""
        let mfgYear = mfgYearTextField.text ?? ""
        let regDate = regDateTextField.text ?? ""
        let bodyType = bodyTypeTextField.text ?? ""
        let leasedBy = leasedByTextField.text ?? ""
        let ownerID = ownerIDTextField.text ?? ""
        
        guard let ID = regNoTextField.text, !ID.isEmpty else {
            showAlert(title: "Error", message: "No Customer Found")
            return
        }
        
        guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chana.azurewebsites.net/api/Vehicle") else {
            self.showAlert(title: "Error", message: "Invalid service URL.")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let customerData: [String: Any] = [
            
            "regNo": NO,
            "regAuthority": regAuthority,
            "make": make,
            "model": model,
            "fuelType": fuelType,
            "variant": variant,
            "engineNo": engineNo,
            "chassisNo": chassisNo,
            "engineCapacity": engineCapacity,
            
            
            
            "seatingCapacity": seatingCapacity,
            "mfgYear": mfgYear,
            "regDate": regDate,
            "bodyType": bodyType,
            "leasedBy": leasedBy,
            "ownerID": ownerID
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: customerData, options: [])
            request.httpBody = jsonData
        } catch {
            self.showAlert(title: "Error", message: "Failed to serialize JSON: \(error.localizedDescription)")
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(title: "Error", message: "Failed to save customer: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    self.showAlert(title: "Error", message: "Server error: \(httpResponse.statusCode)")
                    return
                }
                
                self.showAlert(title: "Success", message: "Customer saved successfully!")
                
            }
        }.resume()
    }
    /*
        // Show success alert
        let alert = UIAlertController(title: "Success",
                                    message: "Form submitted successfully!",
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }*/
    
    /*
    
    @IBAction func updateClick() {
            // Collect form data
            let regNo = regNoTextField.text ?? ""
            let regAuthority = regAuthorityTextField.text ?? ""
            let make = makeTextField.text ?? ""
            let model = modelTextField.text ?? ""
            let fuelType = fuelTypeTextField.text ?? ""
            let variant = variantTextField.text ?? ""
            let engineNo = engineNoTextField.text ?? ""
            let chassisNo = chassisNoTextField.text ?? ""
            let engineCapacity = engineCapacityTextField.text ?? ""
            let seatingCapacity = seatingCapacityTextField.text ?? ""
            let mfgYear = mfgYearTextField.text ?? ""
            let regDate = regDateTextField.text ?? ""
            let bodyType = bodyTypeTextField.text ?? ""
            let leasedBy = leasedByTextField.text ?? ""
            let ownerID = ownerIDTextField.text ?? ""
        

            // Validate mandatory fields
            guard !regNo.isEmpty else {
                showAlert(title: "Error", message: "Registration Number is required.")
                return
            }

            // Prepare URL with identifier for update
            guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chana.azurewebsites.net/api/Vehicle/\(regNo)") else {
                showAlert(title: "Error", message: "Invalid service URL.")
                return
            }

            var request = URLRequest(url: webserviceURL)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // Create payload
            let customerData: [String: Any] = [
                "regNo": regNo,
                "regAuthority": regAuthority,
                "make": make,
                "model": model,
                "fuelType": fuelType,
                "variant": variant,
                "engineNo": engineNo,
                "chassisNo": chassisNo,
                "engineCapacity": engineCapacity,
                "seatingCapacity": seatingCapacity,
                "mfgYear": mfgYear,
                "regDate": regDate,
                "bodyType": bodyType,
                "leasedBy": leasedBy,
                "ownerID": ownerID
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: customerData, options: [])
                request.httpBody = jsonData
            } catch {
                showAlert(title: "Error", message: "Failed to serialize JSON: \(error.localizedDescription)")
                return
            }

            // Send request
            let session = URLSession.shared
            session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showAlert(title: "Error", message: "Failed to update customer: \(error.localizedDescription)")
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                        self.showAlert(title: "Error", message: "Server error: \(httpResponse.statusCode)")
                        return
                    }

                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        print("Server Response: \(responseString)")
                    }

                    self.showAlert(title: "Success", message: "Customer updated successfully!")
                }
            }.resume()
        }
     */
       
    @IBAction func UpdateClick() {
        /*
        let regNo = regNoTextField.text ?? ""
        let regAuthority = regAuthorityTextField.text ?? ""
        let make = makeTextField.text ?? ""
        let model = modelTextField.text ?? ""
        let fuelType = fuelTypeTextField.text ?? ""
        let variant = variantTextField.text ?? ""
        let engineNo = engineNoTextField.text ?? ""
        let chassisNo = chassisNoTextField.text ?? ""
        let engineCapacity = engineCapacityTextField.text ?? ""
        let seatingCapacity = seatingCapacityTextField.text ?? ""
        let mfgYear = mfgYearTextField.text ?? ""
        let regDate = regDateTextField.text ?? ""
        let bodyType = bodyTypeTextField.text ?? ""
        let leasedBy = leasedByTextField.text ?? ""
        let ownerID = ownerIDTextField.text ?? ""
        */
        guard let regNo = regNoTextField.text , !regNo.isEmpty,
         let regAuthority = regAuthorityTextField.text, !regAuthority.isEmpty,
         let make = makeTextField.text, !make.isEmpty,
         let model = modelTextField.text, !model.isEmpty,
         let fuelType = fuelTypeTextField.text, !fuelType.isEmpty,
         let variant = variantTextField.text, !variant.isEmpty,
         let engineNo = engineNoTextField.text, !engineNo.isEmpty,
         let chassisNo = chassisNoTextField.text, !chassisNo.isEmpty,
         let engineCapacity = engineCapacityTextField.text, !engineCapacity.isEmpty,
         let seatingCapacity = seatingCapacityTextField.text, !seatingCapacity.isEmpty,
         let mfgYear = mfgYearTextField.text, !mfgYear.isEmpty,
         let regDate = regDateTextField.text, !regDate.isEmpty,
         let bodyType = bodyTypeTextField.text, !bodyType.isEmpty,
         let leasedBy = leasedByTextField.text, !leasedBy.isEmpty,
         let ownerID = ownerIDTextField.text, !ownerID.isEmpty else {
        print("Invalid input: All fields must be filled.")
            return
        }
        
        // Construct the URL with the CustomerID
        guard let webserviceURL = URL(string: "https://abzcustomerwebapi-chana.azurewebsites.net/api/Customer/\(regNo)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "PUT" // Use PUT for updates
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        /*
        // Prepare the request body
        let customerData: [String: Any] = [
            "CustomerID": ID,
            "CustomerName": Name,
            "CustomerPhone": Phone,
            "CustomerEmail": Email,
            "CustomerAddress": Address
        ]*/
        let customerData: [String: Any] = [
            "regNo": regNo,
            "regAuthority": regAuthority,
            "make": make,
            "model": model,
            "fuelType": fuelType,
            "variant": variant,
            "engineNo": engineNo,
            "chassisNo": chassisNo,
            "engineCapacity": engineCapacity,
            "seatingCapacity": seatingCapacity,
            "mfgYear": mfgYear,
            "regDate": regDate,
            "bodyType": bodyType,
            "leasedBy": leasedBy,
            "ownerID": ownerID
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: customerData, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
            }
            request.httpBody = jsonData
        } catch {
            print("Failed to serialize JSON: \(error.localizedDescription)")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request failed: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                    print("Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                } else {
                    print("Server returned an error: \(httpResponse.statusCode)")
                }
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response from server: \(jsonResponse)")
                    }
                } catch {
                    print("Failed to parse JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

    
    
    // Helper method to parse server error details
    private func parseServerError(data: Data?) -> String? {
        guard let data = data else { return nil }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let message = json["message"] as? String {
                return message
            }
        } catch {
            print("Failed to parse error response: \(error)")
        }
        return nil
    }


    @IBAction func getClick() {
            // Collect form data for query parameters
            let regNo = regNoTextField.text ?? ""

            // Validate mandatory fields (if required)
            guard !regNo.isEmpty else {
                showAlert(title: "Error", message: "Registration Number is required.")
                return
            }

            // Prepare URL with query parameters
            guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chana.azurewebsites.net/api/Vehicle/\(regNo)") else {
                showAlert(title: "Error", message: "Invalid service URL.")
                return
            }

        // Create the GET request
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Request failed: \(error.localizedDescription)")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                    } else {
                        print("Server returned an error: \(httpResponse.statusCode)")
                    }
                }
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response from server: \(jsonResponse)")
                        DispatchQueue.main.async {
                            // Safely unwrap and update the UI with the fetched data
                            self.regAuthorityTextField.text = jsonResponse["regAuthority"] as? String ?? "N/A"
                            self.makeTextField.text = jsonResponse["make"] as? String ?? "N/A"
                            self.modelTextField.text = jsonResponse["model"] as? String ?? "N/A"
                            self.variantTextField.text = jsonResponse["variant"] as? String ?? "N/A"
                            self.engineNoTextField.text = jsonResponse["engineNo"] as? String ?? "N/A"
                            
                            self.chassisNoTextField.text = jsonResponse["chassisNo"] as? String ?? "N/A"
                            self.engineCapacityTextField.text = jsonResponse["engineCapacity"] as? String ?? "N/A"
                            self.seatingCapacityTextField.text = jsonResponse["seatingCapacity"] as? String ?? "N/A"
                            self.mfgYearTextField.text = jsonResponse["mfgYear"] as? String ?? "N/A"
                            self.regDateTextField.text = jsonResponse["regDate"] as? String ?? "N/A"
                            self.bodyTypeTextField.text = jsonResponse["bodyType"] as? String ?? "N/A"
                            self.leasedByTextField.text = jsonResponse["leasedBy"] as? String ?? "N/A"
                            self.ownerIDTextField.text = jsonResponse["ownerID"] as? String ?? "N/A"
                            
                            //self.ownerIDTextField.text = (jsonResponse["ownerID"] as? Int).map { String($0) } ?? "N/A"

                           
                            self.fuelTypeTextField.text = jsonResponse["fuelType"] as? String ?? "N/A"
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Failed to parse JSON: \(error.localizedDescription)")
                    }
                }
            }
        }
        task.resume()

}

    
    
    
    
       
    private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
}
