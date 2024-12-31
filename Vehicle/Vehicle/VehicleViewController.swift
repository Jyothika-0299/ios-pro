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
    @IBOutlet weak var DeleteButton : UIButton!
    

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
                
                self.showAlert(title: "Success", message: "Vehicle details saved successfully!")
                
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
        guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chana.azurewebsites.net/api/Vehicle/\(regNo)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "PUT" // Use PUT for updates
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        let vehicleData: [String: Any] = [
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
            let jsonData = try JSONSerialization.data(withJSONObject: vehicleData, options: [])
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

    @IBAction func clickdelete(_ sender: UIButton) {
        guard let regNo = regNoTextField.text, !regNo.isEmpty else {
            print("Invalid input: Register Number must be provided.")
            return
        }
        
        // Construct the URL with CustomerID as a path parameter
        guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chana.azurewebsites.net/api/Vehicle/\(regNo)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Start the session
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request failed: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    print("Vehicle info deleted successfully.")
                    DispatchQueue.main.async {
                        print("Vehicle info deleted successfully.")
                    }
                } else {
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                    } else {
                        print("Server returned an error: \(httpResponse.statusCode)")
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


