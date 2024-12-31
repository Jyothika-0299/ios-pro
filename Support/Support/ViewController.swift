//
//  ViewController.swift
//  Support
//
//  Created by FCI on 29/12/24.
//



import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var queryID: UITextField!
    @IBOutlet var custID: UITextField!
    @IBOutlet var descript: UITextField!
    @IBOutlet var queryDate: UITextField!
    @IBOutlet var status: UITextField!
    
    var qid: String?
    var cid: String?
    var des: String?
    var qdate: String?
    var stat: String?
    
    
    @IBOutlet var save: UIButton!
    @IBOutlet var update: UIButton!
    @IBOutlet var delete: UIButton!
    @IBOutlet var get: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func clickSave(_ sender: UIButton) {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoianlvdGhpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoidHJhaW5pbmciLCJleHAiOjE3MzUzODg4NjcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.8yqOHYn91rrDaRJEHWEV8Hdgk5D5QcYUJ_-G3YDgGCg"
        guard let QID = queryID.text, !QID.isEmpty,
              let CID = custID.text, !CID.isEmpty,
              let DES = descript.text, !DES.isEmpty,
              let QDATE = queryDate.text, !QDATE.isEmpty,
              let STATUS = status.text, !STATUS.isEmpty else {
            print("Invalid input: All fields must be filled.")
            return
        }
        
        guard let webserviceURL = URL(string: "https://abzquerywebapi-chanad.azurewebsites.net/api/CustomerQuery/\(accessToken)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let queryinfo: [String: Any] = [
            "QueryID": QID,
            "CustomerID": CID,
            "Description": DES,
            "QueryDate": QDATE,
            "Status": STATUS
        ]
        

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: queryinfo, options: [])
            request.httpBody = jsonData
        } catch {
            showAlert(title: "Error", message: "Failed to serialize JSON: \(error.localizedDescription)")
            return
        }
        
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
        
        
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        self.showAlert(title: "Success", message: "Response from server: \(jsonResponse)")
                    }
                } catch {
                    self.showAlert(title: "Error", message: "Failed to parse JSON: \(error.localizedDescription)")
                }
            }
            if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                print("Server Response: \(errorMessage)")
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
    
        @IBAction func clickUpdat(_ sender: UIButton) {
            let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoianlvdGhpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoidHJhaW5pbmciLCJleHAiOjE3MzUzODg4NjcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.8yqOHYn91rrDaRJEHWEV8Hdgk5D5QcYUJ_-G3YDgGCg"

            guard let QID = queryID.text, !QID.isEmpty,
                  let CID = custID.text, !CID.isEmpty,
                  let DES = descript.text, !DES.isEmpty,
                  let QDATE = queryDate.text, !QDATE.isEmpty,
                  let STATUS = status.text, !STATUS.isEmpty else {
                print("Invalid input: All fields must be filled.")
                return
            }
        
        // Construct the URL with the CustomerID
        guard let webserviceURL = URL(string: "https://abzquerywebapi-chanad.azurewebsites.net/api/CustomerQuery/\(QID)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "PUT" // Use PUT for updates
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       
            
            let queryinfo: [String: Any] = [
                "QueryID": QID,
                "CustomerID": CID,
                "Description": DES,
                "QueryDate": QDATE,
                "Status": STATUS
            ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: queryinfo, options: [])
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
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoianlvdGhpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoidHJhaW5pbmciLCJleHAiOjE3MzUzODg4NjcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.8yqOHYn91rrDaRJEHWEV8Hdgk5D5QcYUJ_-G3YDgGCg"
        guard let QID = queryID.text, !QID.isEmpty else {
            print("Invalid input: Product ID must be provided.")
            return
        }
        
        // Construct the URL with CustomerID as a path parameter
        guard let webserviceURL = URL(string: "https://abzquerywebapi-chanad.azurewebsites.net/api/CustomerQuery/\(QID)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
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
                    print("Product Details deleted successfully.")
                    DispatchQueue.main.async {
                        print("Product Details deleted successfully.")
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
        
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoianlvdGhpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoidHJhaW5pbmciLCJleHAiOjE3MzUzODg4NjcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.8yqOHYn91rrDaRJEHWEV8Hdgk5D5QcYUJ_-G3YDgGCg"  // Make sure this is the correct token
        guard let QID = queryID.text, !QID.isEmpty else {
            print("Invalid input: Product ID must be filled.")
            return
        }
        
        // Construct the URL
        guard let webserviceURL = URL(string: "https://abzquerywebapi-chanad.azurewebsites.net/api/CustomerQuery/\(QID)") else {
            print("Invalid URL")
            return
        }
        // Debug print the URL
        print("Request URL: \(webserviceURL)")

        // Create the GET request
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "GET"
        
        // Ensure the authorization header is set correctly
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Debug print the headers to ensure token is being passed
        print("Authorization Header: \(request.allHTTPHeaderFields?["Authorization"] ?? "No Authorization Header")")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            // Handle connection errors
            if let error = error {
                self.showAlert(title: "Error", message: "Request failed: \(error.localizedDescription)")
                return
            }

            // Handle HTTP response
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")

                if !(200...299).contains(httpResponse.statusCode) {
                    if httpResponse.statusCode == 401 {
                        self.showAlert(title: "Error", message: "Unauthorized: Check your access token.")
                    } else if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        self.showAlert(title: "Error", message: "Server Error (\(httpResponse.statusCode)): \(errorMessage)")
                    } else {
                        self.showAlert(title: "Error", message: "Server returned an error: \(httpResponse.statusCode)")
                    }
                    return
                }
            }

            // Handle response data
            guard let data = data else {
                self.showAlert(title: "Error", message: "No data received from server.")
                return
            }
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response from server: \(jsonResponse)")
                        DispatchQueue.main.async {
                            // Safely unwrap and update the UI with the fetched data
                            self.queryID.text = jsonResponse["QueryID"] as? String ?? "N/A"
                            self.custID.text = jsonResponse["CustomerID"] as? String ?? "N/A"
                            self.descript.text = jsonResponse["Description"] as? String ?? "N/A"
                            self.queryDate.text = jsonResponse["QueryDate"] as? String ?? "N/A"
                            self.status.text = jsonResponse["Status"] as? String ?? "N/A"
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Failed to parse JSON: \(error.localizedDescription)")
                    }
                }
            
        }
        task.resume()
    }
}


