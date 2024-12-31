//
//  VehicleViewController.swift
//  MenuBar
//
//  Created by FCI on 26/12/24.
//

import UIKit

class Veh1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var RegNo: UITextField!
    @IBOutlet var RegAuth: UITextField!
    @IBOutlet var OwnId: UITextField!
    @IBOutlet var Make: UITextField!
    @IBOutlet var model: UITextField!
    @IBOutlet var Fueltype: UITextField!
    @IBOutlet var Variant: UITextField!
    @IBOutlet var EngineNo: UITextField!
    @IBOutlet var ChassiNo: UITextField!
    @IBOutlet var EngineCap: UITextField!
    @IBOutlet var SeatingCap: UITextField!
    @IBOutlet var MfgYear: UITextField!
    @IBOutlet var regdate: UITextField!
    @IBOutlet var BodyType: UITextField!
    @IBOutlet var LeasedBy: UITextField!
    
    
    @IBOutlet var Save: UIButton!
    @IBOutlet var Update: UIButton!
    @IBOutlet var Delete: UIButton!
    
    /*
    var regNo: String?
    var make: String?
    var fuelType: String?
    var chassisNo: String?
    var engineNo: String?
    var regDate: String?
*/
    
    var pv1: UIPickerView!
    var OwnerId: [String] = []
    
    var pv2: UIPickerView!
    var FuelType: [String] = []
    
    var pv3: UIPickerView!
    var SeatingCapacity: [String] = []
    
    var dp1: UIDatePicker!
    var df1: DateFormatter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initialize claim statuses for the picker view
        OwnerId = ["jyo999","nik555","vis777"]
        // Set up the UIPickerView for ClaimStatus
        pv1 = UIPickerView()
        pv1.delegate = self
        pv1.dataSource = self
        OwnId.inputView = pv1
        
        FuelType = ["P", "D", "C", "L", "E"]
        
        pv2 = UIPickerView()
        pv2.delegate = self
        pv2.dataSource = self
        Fueltype.inputView = pv2
        
        
        SeatingCapacity = ["2", "5", "8", "12", "16"]
        
        pv3 = UIPickerView()
        pv3.delegate = self
        pv3.dataSource = self
        SeatingCap.inputView = pv3
        
        // Set up the UIDatePickers for the dates
        dp1 = UIDatePicker()
        dp1.datePickerMode = .date
        dp1.preferredDatePickerStyle = .wheels
        dp1.addTarget(self, action: #selector(dp1Click), for: .valueChanged)
        regdate.inputView = dp1
    
        fetchCustomerIDs()
    }
    

    
    
    @IBAction func ClickSave(_ sender: UIButton) {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJld2UiLCJleHAiOjE3MzU2NDQ5MTcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.oDiC-aM-hYtKDbqI8CP_J-KZqYt9nJPgJhuib0dtFZw"
        
        guard let regNo = RegNo.text, !regNo.isEmpty,
              let regAuth = RegAuth.text, !regAuth.isEmpty,
              let ownId = OwnId.text, !ownId.isEmpty,
              let make = Make.text, !make.isEmpty,
              let model = model.text, !model.isEmpty,
              let fuelType = Fueltype.text, !fuelType.isEmpty,
              let variant = Variant.text, !variant.isEmpty,
              let engineNo = EngineNo.text, !engineNo.isEmpty,
              let chassiNo = ChassiNo.text, !chassiNo.isEmpty,
              let engineCap = EngineCap.text, !engineCap.isEmpty,
              let seatingCap = SeatingCap.text, !seatingCap.isEmpty,
              let mfgYear = MfgYear.text, !mfgYear.isEmpty,
              let regDate = regdate.text, !regDate.isEmpty,
              let bodyType = BodyType.text, !bodyType.isEmpty,
              let leasedBy = LeasedBy.text, !leasedBy.isEmpty else {
            showAlert(title: "Error", message: "All fields must be filled.")
            return
        }

        guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/\(accessToken)") else {
            showAlert(title: "Error", message: "Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let vehicleDetails: [String: Any] = [
            "regNo": regNo,
            "regAuthority": regAuth,
            "make": make,
            "model": model,
            "fuelType": fuelType,
            "variant": variant,
            "engineNo": engineNo,
            "chassisNo": chassiNo,
            "engineCapacity": Int(engineCap) ?? 0,
            "seatingCapacity": Int(seatingCap) ?? 0,
            "mfgYear": mfgYear,
            "regDate": regDate,
            "bodyType": bodyType,
            "leasedBy": leasedBy,
            "ownerId": ownId
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: vehicleDetails, options: [])
            request.httpBody = jsonData
        } catch {
            showAlert(title: "Error", message: "Failed to serialize JSON: \(error.localizedDescription)")
            print("Failed to serialize JSON: \(error.localizedDescription)")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                self.showAlert(title: "Error", message: "Request failed: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                    self.showAlert(title: "Error", message: "Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                } else {
                    self.showAlert(title: "Error", message: "Server returned an error: \(httpResponse.statusCode)")
                }
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        self.showAlert(title: "Success", message: "Response from server: \(jsonResponse)")
                    }
                } catch {
                    self.showAlert(title: "Error", message: "Failed to parse JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        
        
    }

    
    @IBAction func ClickUpdate(_ sender: UIButton) {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJld2UiLCJleHAiOjE3MzU2NDQ5MTcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.oDiC-aM-hYtKDbqI8CP_J-KZqYt9nJPgJhuib0dtFZw"

        // Ensure all fields are filled
        guard let regNo = RegNo.text, !regNo.isEmpty,
              let regAuth = RegAuth.text, !regAuth.isEmpty,
              let ownId = OwnId.text, !ownId.isEmpty,
              let make = Make.text, !make.isEmpty,
              let model = model.text, !model.isEmpty,
              let fuelType = Fueltype.text, !fuelType.isEmpty,
              let variant = Variant.text, !variant.isEmpty,
              let engineNo = EngineNo.text, !engineNo.isEmpty,
              let chassiNo = ChassiNo.text, !chassiNo.isEmpty,
              let engineCap = EngineCap.text, !engineCap.isEmpty,
              let seatingCap = SeatingCap.text, !seatingCap.isEmpty,
              let mfgYear = MfgYear.text, !mfgYear.isEmpty,
              let regDate = regdate.text, !regDate.isEmpty,
              let bodyType = BodyType.text, !bodyType.isEmpty,
              let leasedBy = LeasedBy.text, !leasedBy.isEmpty else {
            showAlert(title: "Error", message: "Invalid input: All fields must be filled.")
            return
        }

        // Construct URL
        guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/\(regNo)") else {
            showAlert(title: "Error", message: "Invalid URL")
            return
        }

        // Configure PUT request
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare JSON payload
        let vehicleDetails: [String: Any] = [
            "regNo": regNo,
            "regAuthority": regAuth,
            "ownerId": ownId,
            "make": make,
            "model": model,
            "fuelType": fuelType,
            "variant": variant,
            "engineNo": engineNo,
            "chassisNo": chassiNo,
            "engineCapacity": Int(engineCap) ?? 0,
            "seatingCapacity": Int(seatingCap) ?? 0,
            "mfgYear": mfgYear,
            "regDate": regDate,
            "bodyType": bodyType,
            "leasedBy": leasedBy
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: vehicleDetails, options: [])
            request.httpBody = jsonData
        } catch {
            showAlert(title: "Error", message: "Failed to serialize JSON: \(error.localizedDescription)")
            print("Failed to serialize JSON: \(error.localizedDescription)")
            return
        }

        // Perform the request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                self.showAlert(title: "Error", message: "Request failed: \(error.localizedDescription)")
                print("Request failed: \(error.localizedDescription)")
                return
            }

            // Handle response
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if !(200...299).contains(httpResponse.statusCode) {
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        self.showAlert(title: "Error", message: "Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                        print("Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                    } else {
                        self.showAlert(title: "Error", message: "Server returned an error: \(httpResponse.statusCode)")
                        print("Server returned an error: \(httpResponse.statusCode)")
                    }
                    return
                }
            }

            // Parse response data
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        DispatchQueue.main.async {
                            self.showAlert(title: "Success", message: "Response from server: \(jsonResponse)")
                        }
                        print("Response from server: \(jsonResponse)")
                    }
                } catch {
                    self.showAlert(title: "Error", message: "Failed to parse JSON: \(error.localizedDescription)")
                    print("Failed to parse JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

    
    
    
    
    
    @IBAction func ClickDelete(_ sender: UIButton) {
        
        let accessToken="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJld2UiLCJleHAiOjE3MzU2NDQ5MTcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.oDiC-aM-hYtKDbqI8CP_J-KZqYt9nJPgJhuib0dtFZw"
        
        guard let regNo = RegNo.text, !regNo.isEmpty else {
            showAlert(title: "Error", message: "Invalid input: Registration Number must be provided.")
            return
        }
        
        guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/\(regNo)") else {
            showAlert(title: "Error", message: "Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                self.showAlert(title: "Error", message: "Request failed: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Success", message: "Vehicle deleted successfully.")
                    }
                } else {
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        self.showAlert(title: "Error", message: "Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                    } else {
                        self.showAlert(title: "Error", message: "Server returned an error: \(httpResponse.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
    @IBAction func ClickGet(_ sender: UIButton) {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJld2UiLCJleHAiOjE3MzU2NDQ5MTcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.oDiC-aM-hYtKDbqI8CP_J-KZqYt9nJPgJhuib0dtFZw"  // Replace with your actual token

        // Validate Registration Number
        guard let regNo = RegNo.text, !regNo.isEmpty else {
            showAlert(title: "Error", message: "Registration Number must be filled.")
            return
        }

        // Construct the URL
        guard let webserviceURL = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/\(regNo)") else {
            showAlert(title: "Error", message: "Invalid URL")
            return
        }

        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                self.showAlert(title: "Error", message: "Request failed: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if !(200...299).contains(httpResponse.statusCode) {
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        self.showAlert(title: "Error", message: "Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                    } else {
                        self.showAlert(title: "Error", message: "Server returned an error: \(httpResponse.statusCode)")
                    }
                    return
                }
            }

            guard let data = data else {
                self.showAlert(title: "Error", message: "No data received from server.")
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response from server: \(jsonResponse)")

                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self.RegNo.text = jsonResponse["regNo"] as? String ?? "N/A"
                        self.RegAuth.text = jsonResponse["regAuthority"] as? String ?? "N/A"
                        self.OwnId.text = jsonResponse["ownerId"] as? String ?? "N/A"
                        self.Make.text = jsonResponse["make"] as? String ?? "N/A"
                        self.model.text = jsonResponse["model"] as? String ?? "N/A"
                        self.Fueltype.text = jsonResponse["fuelType"] as? String ?? "N/A"
                        self.Variant.text = jsonResponse["variant"] as? String ?? "N/A"
                        self.EngineNo.text = jsonResponse["engineNo"] as? String ?? "N/A"
                        self.ChassiNo.text = jsonResponse["chassisNo"] as? String ?? "N/A"
                        self.EngineCap.text = "\(jsonResponse["engineCapacity"] as? Int ?? 0)" // Convert number to string
                        self.SeatingCap.text = "\(jsonResponse["seatingCapacity"] as? Int ?? 0)" // Convert number to string
                        self.MfgYear.text = jsonResponse["mfgYear"] as? String ?? "N/A"
                        self.regdate.text = jsonResponse["regDate"] as? String ?? "N/A"
                        self.BodyType.text = jsonResponse["bodyType"] as? String ?? "N/A"
                        self.LeasedBy.text = jsonResponse["leasedBy"] as? String ?? "N/A"
                    }
                } else {
                    self.showAlert(title: "Error", message: "Unexpected response format.")
                }
            } catch {
                self.showAlert(title: "Error", message: "Failed to parse JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }


    
    
    
    private func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    // UIPickerViewDelegate and UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Single component in each picker
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pv1 {
            return OwnerId.count
        } else if pickerView == pv2 {
            return FuelType.count
        } else if pickerView == pv3 {
            return SeatingCapacity.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pv1 {
            return OwnerId[row]
        } else if pickerView == pv2 {
            return FuelType[row]
        } else if pickerView == pv3 {
            return SeatingCapacity[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pv1 {
            OwnId.text = OwnerId[row]
        } else if pickerView == pv2 {
            Fueltype.text = FuelType[row]
        } else if pickerView == pv3 {
            SeatingCap.text = SeatingCapacity[row]
        }
    }
    

    @objc func dp1Click() {
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS" // ISO 8601 format with milliseconds

         // Convert the selected date into the formatted string
         let formattedDate = dateFormatter.string(from: dp1.date)

         // Set the formatted date string to the regDate text field
         regdate.text = formattedDate
    }
    
    

    
    func fetchCustomerIDs() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJld2UiLCJleHAiOjE3MzU2NDQ5MTcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.oDiC-aM-hYtKDbqI8CP_J-KZqYt9nJPgJhuib0dtFZw"
        
        // Correct URL without token in the path
        let url = URL(string: "https://abzcustomerwebapi-chanad.azurewebsites.net/api/Customer")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Pass token in header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Failed to get HTTP response.")
                return
            }
            
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            if !(200...299).contains(httpResponse.statusCode) {
                print("Server error with status code: \(httpResponse.statusCode)")
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8) ?? "Unable to decode response data as String"
                    print("Response Data String: \(responseString)")
                }
                return
            }
            
            if let data = data {
                let responseString = String(data: data, encoding: .utf8) ?? "Unable to decode response data as String"
                print("Response Data String: \(responseString)")
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        for customer in jsonResponse {
                            if let customerID = customer["customerID"] as? String {
                                print("CustomerID: \(customerID)")
                                // Assuming self.CustomerID exists as an array property
                                self.OwnerId.append(customerID)
                            } else {
                                print("CustomerID not found for product: \(customer)")
                            }
                        }
                    } else {
                        print("Unexpected JSON structure.")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    
    //regno picker view
    
}

