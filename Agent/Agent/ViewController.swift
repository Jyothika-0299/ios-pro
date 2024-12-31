
//
//  ViewController.swift
//  Agent
//
//  Created by FCI on 23/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var agentID: UITextField!
    @IBOutlet var agentName: UITextField!
    @IBOutlet var agentPhone: UITextField!
    @IBOutlet var agentEmail: UITextField!
    @IBOutlet var lisencecode: UITextField!
    
    var id: String?
    var Name: String?
    var Phone: String?
    var Email: String?
    var Lisence: String?
    
    
    @IBOutlet var save: UIButton!
    @IBOutlet var update: UIButton!
    @IBOutlet var delete: UIButton!
    @IBOutlet var get: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func clickSave(_ sender: UIButton) {
        guard let ID = agentID.text, !ID.isEmpty,
              let Name = agentName.text, !Name.isEmpty,
              let Phone = agentPhone.text, !Phone.isEmpty,
              let Email = agentEmail.text, !Email.isEmpty,
              let Lisence = lisencecode.text, !Lisence.isEmpty else {
            print("Invalid input: All fields must be filled.")
            return
        }
        
        guard let webserviceURL = URL(string: "https://abzagentwebapi-chana.azurewebsites.net/api/Agent/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let agentData: [String: Any] = [
            "AgentID": ID,
            "AgentName": Name,
            "AgentPhone": Phone,
            "AgentEmail": Email,
            "LisenceCode": Lisence
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: agentData, options: [])
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

        guard let ID = agentID.text, !ID.isEmpty,
              let Name = agentName.text, !Name.isEmpty,
              let Phone = agentPhone.text, !Phone.isEmpty,
              let Email = agentEmail.text, !Email.isEmpty,
              let Lisence = lisencecode.text, !Lisence.isEmpty else {
            print("Invalid input: All fields must be filled.")
            return
        }
        
        // Construct the URL with the CustomerID
        guard let webserviceURL = URL(string: "https://abzagentwebapi-chana.azurewebsites.net/api/Agent/\(ID)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "PUT" // Use PUT for updates
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the request body
        let agentData: [String: Any] = [
            "AgentID": ID,
            "AgentName": Name,
            "AgentPhone": Phone,
            "AgentEmail": Email,
            "LisenceCode": Lisence
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: agentData, options: [])
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
        guard let ID = agentID.text, !ID.isEmpty else {
            print("Invalid input: Customer ID must be provided.")
            return
        }
        
        // Construct the URL with CustomerID as a path parameter
        guard let webserviceURL = URL(string: "https://abzagentwebapi-chana.azurewebsites.net/api/Agent/\(ID)") else {
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
        guard let ID = agentID.text, !ID.isEmpty else {
            print("Invalid input: Customer ID must be filled.")
            return
        }
        
        // Construct the URL
        guard let webserviceURL = URL(string: "https://abzagentwebapi-chana.azurewebsites.net/api/Agent/\(ID)") else {
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
                            self.agentName.text = jsonResponse["AgentName"] as? String ?? "N/A"
                            self.agentPhone.text = jsonResponse["AgentPhone"] as? String ?? "N/A"
                            self.agentEmail.text = jsonResponse["AgentEmail"] as? String ?? "N/A"
                            self.lisencecode.text = jsonResponse["LisenceCode"] as? String ?? "N/A"
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




