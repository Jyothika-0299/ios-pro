//
//  ViewController.swift
//  productAddOn
//
//  Created by FCI on 27/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var PolicyNo: UITextField!
    @IBOutlet var AddOnId: UITextField!
    @IBOutlet var Payment: UITextField!
    
    @IBOutlet var Save: UIButton!
    @IBOutlet var Update: UIButton!
    @IBOutlet var Delete: UIButton!
    @IBOutlet var Fetch: UIButton!
    
    let baseURL = "https://abzcustomerwebapi-chana.azurewebsites.net/api" // Base URL
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Helper function for showing alerts
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Helper function for making API requests
    func sendRequest(endpoint: String, method: String, body: [String: Any]? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("Failed to serialize JSON: \(error.localizedDescription)")
                return
            }
        }
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: completion).resume()
    }
    
    // Save action
    @IBAction func ClickSave(_ sender: UIButton) {
        guard let PoliID = PolicyNo.text, !PoliID.isEmpty,
              let AddId = AddOnId.text, !AddId.isEmpty,
              let PaymentID = Payment.text, !PaymentID.isEmpty else {
            showAlert(message: "All fields must be filled.")
            return
        }
        
        let customerData: [String: Any] = [
            "PolicyID": PoliID,
            "AddOnID": AddId,
            "Payment": PaymentID
        ]
        
        sendRequest(endpoint: "Customer", method: "POST", body: customerData) { data, response, error in
            if let error = error {
                self.showAlert(message: "Request failed: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                self.showAlert(message: "Server returned an error: \(httpResponse.statusCode)")
                return
            }
            
            self.showAlert(message: "Policy AddOn saved successfully.")
        }
    }
    
    // Update action
    @IBAction func ClickUpdate(_ sender: UIButton) {
        guard let PoliID = PolicyNo.text, !PoliID.isEmpty,
              let AddId = AddOnId.text, !AddId.isEmpty,
              let PaymentID = Payment.text, !PaymentID.isEmpty else {
            showAlert(message: "All fields must be filled.")
            return
        }
        
        let customerData: [String: Any] = [
            "PolicyID": PoliID,
            "AddOnID": AddId,
            "Payment": PaymentID
        ]
        
        sendRequest(endpoint: "PolicyAddOn/\(PoliID)", method: "PUT", body: customerData) { data, response, error in
            if let error = error {
                self.showAlert(message: "Request failed: \(error.localizedDescription)")
                return
            }
            
            self.showAlert(message: "Policy AddOn updated successfully.")
        }
    }
    
    // Delete action
    @IBAction func ClickDelete(_ sender: UIButton) {
        guard let AddId = AddOnId.text, !AddId.isEmpty else {
            showAlert(message: "AddON ID must be provided.")
            return
        }
        
        sendRequest(endpoint: "AddOnID/\(AddId)", method: "DELETE") { data, response, error in
            if let error = error {
                self.showAlert(message: "Request failed: \(error.localizedDescription)")
                return
            }
            
            self.showAlert(message: "AddOnID deleted successfully.")
        }
    }
    
    // Fetch action
    @IBAction func ClickFetch(_ sender: UIButton) {
        guard let AddId = AddOnId.text, !AddId.isEmpty else {
            showAlert(message: "AddON ID must be filled.")
            return
        }
        
        sendRequest(endpoint: "Customer/\(AddId)", method: "GET") { data, response, error in
            if let error = error {
                self.showAlert(message: "Request failed: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        DispatchQueue.main.async {
                            self.PolicyNo.text = jsonResponse["PolicyID"] as? String
                            self.Payment.text = jsonResponse["Payment"] as? String
                            self.AddOnId.text = jsonResponse["AddOnID"] as? String
                        }
                    }
                } catch {
                    self.showAlert(message: "Failed to parse response.")
                }
            }
        }
    }
}
