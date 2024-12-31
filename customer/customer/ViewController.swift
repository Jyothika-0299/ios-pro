//
//  ViewController.swift
//  customer
//
//  Created by FCI on 23/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var custID: UITextField!
    @IBOutlet var custName: UITextField!
    @IBOutlet var custPhone: UITextField!
    @IBOutlet var custEmail: UITextField!
    @IBOutlet var custAddress: UITextField!
    
    var id: String?
    var Name: String?
    var Phone: String?
    var Email: String?
    var Address: String?
    
    
    @IBOutlet var save: UIButton!
    @IBOutlet var update: UIButton!
    @IBOutlet var delete: UIButton!
    @IBOutlet var get: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func clickSave(_ sender: UIButton) {
        guard let ID = custID.text, !ID.isEmpty,
              let Name = custName.text, !Name.isEmpty,
              let Phone = custPhone.text, !Phone.isEmpty,
              let Email = custEmail.text, !Email.isEmpty,
              let Address = custAddress.text, !Address.isEmpty else {
            print("Invalid input: All fields must be filled.")
            return
        }
        
        guard let webserviceURL = URL(string: "https://abzcustomerwebapi-chana.azurewebsites.net/api/Customer") else {
            print("Invalid URL")
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

    
    @IBAction func clickUpdat(_ sender: UIButton) {

        guard let ID = custID.text, !ID.isEmpty,
              let Name = custName.text, !Name.isEmpty,
              let Phone = custPhone.text, !Phone.isEmpty,
              let Email = custEmail.text, !Email.isEmpty,
              let Address = custAddress.text, !Address.isEmpty else {
            print("Invalid input: All fields must be filled.")
            return
        }
        
        // Construct the URL with the CustomerID
        guard let webserviceURL = URL(string: "https://abzcustomerwebapi-chana.azurewebsites.net/api/Customer/\(ID)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "PUT" // Use PUT for updates
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the request body
        let customerData: [String: Any] = [
            "CustomerID": ID,
            "CustomerName": Name,
            "CustomerPhone": Phone,
            "CustomerEmail": Email,
            "CustomerAddress": Address
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

    
    
    @IBAction func clickdelete(_ sender: UIButton) {
        guard let ID = custID.text, !ID.isEmpty else {
            print("Invalid input: Customer ID must be provided.")
            return
        }
        
        // Construct the URL with CustomerID as a path parameter
        guard let webserviceURL = URL(string: "https://abzcustomerwebapi-chana.azurewebsites.net/api/Customer/\(ID)") else {
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
                    print("Customer deleted successfully.")
                    DispatchQueue.main.async {
                        print("Customer deleted successfully.")
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
    
    
    @IBAction func clickGet(_ sender: UIButton) {
        guard let ID = custID.text, !ID.isEmpty else {
            print("Invalid input: Customer ID must be filled.")
            return
        }
        
        // Construct the URL
        guard let webserviceURL = URL(string: "https://abzcustomerwebapi-chana.azurewebsites.net/api/Customer/\(ID)") else {
            print("Invalid URL")
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
                            self.custName.text = jsonResponse["customerName"] as? String ?? "N/A"
                            self.custPhone.text = jsonResponse["customerPhone"] as? String ?? "N/A"
                            self.custEmail.text = jsonResponse["customerEmail"] as? String ?? "N/A"
                            self.custAddress.text = jsonResponse["customerAddress"] as? String ?? "N/A"
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


    
    
}

