//
//  ViewController.swift
//  Insurance
//
//  Created by FCI on 24/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var CustID: UITextField!
    @IBOutlet var CustName: UITextField!
    @IBOutlet var CustPhone: UITextField!
    @IBOutlet var CustEmail: UITextField!
    @IBOutlet var CustAddress: UITextField!
    
    @IBOutlet var SaveBtn: UIButton!
    @IBOutlet var NextBtn: UIButton!
    @IBOutlet var SearchBtn: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NextBtn.isEnabled = false
        
        
    }
    

    
    @IBAction func ClickSave(_ sender: UIButton) {
        
        validateForm()
    }
    @IBAction func Search(_ sender: UIButton) {
        guard let ID = CustID.text, !ID.isEmpty else {
                    print("Invalid input: Customer ID must be filled.")
                    return
                }
                
                // Construct the URL
                guard let webserviceURL = URL(string: "https://abzcustomerwebapi-hana.azurewebsites.net/api/Customer/\(ID)") else {
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
                                    self.CustName.text = jsonResponse["customerName"] as? String ?? "N/A"
                                    self.CustPhone.text = jsonResponse["customerPhone"] as? String ?? "N/A"
                                    self.CustEmail.text = jsonResponse["customerEmail"] as? String ?? "N/A"
                                    self.CustAddress.text = jsonResponse["customerAddress"] as? String ?? "N/A"
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
    
        
    @IBAction func ClickNext(_ sender: UIButton) {
        let ID = CustID.text ?? ""
        let Name = CustName.text ?? ""
        let Phone = CustPhone.text ?? ""
        let Email = CustEmail.text ?? ""
        let Address = CustAddress.text ?? ""
        
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
                self.NextBtn?.isEnabled = true
            }
        }.resume()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextScreen = storyboard.instantiateViewController(withIdentifier: "storyid1") as? ProfileViewController {
            nextScreen.CustomerID = CustID.text
            nextScreen.CustomerName = CustName.text
            nextScreen.CustomerEmail = CustEmail.text
            nextScreen.CustomerPhone = CustPhone.text
            nextScreen.CustomerAddress = CustAddress.text
            //self.navigationController?.pushViewController(nextScreen, animated: true)
            
        }
    }
    
    
    
    
    
    
    // MARK: - Validation
    private func validateForm() {
        let isFormValid = !(CustID.text?.isEmpty ?? true) &&
            isValidID(CustID.text) &&
            !(CustName.text?.isEmpty ?? true) &&
            isValidName(CustName.text ?? "") &&
            !(CustPhone.text?.isEmpty ?? true) &&
            (CustPhone.text?.count ?? 0) >= 10 &&
            isValidEmail(CustEmail.text) &&
            !(CustAddress.text?.isEmpty ?? true)

        NextBtn.isEnabled = isFormValid
        NextBtn?.backgroundColor = isFormValid ? .systemBlue : .gray
        
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    private func isValidID(_ id: String?) -> Bool {
        guard let id = id else { return false }
        let idRegex = "^[0-9]{3,10}$"
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
        return idPredicate.evaluate(with: id)
    }
    
    private func isValidName(_ name: String) -> Bool {
        let nameRegex = "^[a-zA-Z ]{2,50}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
    
    // MARK: - Alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
                
       let nextScreen = storyboard.instantiateViewController(withIdentifier: "storyid1") as! ProfileViewController
                
                
        
       self.navigationController?.pushViewController(nextScreen, animated: true)
        nextScreen.CustomerID = CustID.text
        nextScreen.CustomerName = CustName.text
        nextScreen.CustomerEmail = CustEmail.text
        nextScreen.CustomerPhone = CustPhone.text
        nextScreen.CustomerAddress = CustAddress.text
        
    }*/
    
    
    
    /*
    @IBAction func home(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextScreen = storyboard.instantiateViewController(withIdentifier: "storyid1") as? ProfileViewController {
            nextScreen.CustomerID = CustID.text
            nextScreen.CustomerName = CustName.text
            nextScreen.CustomerEmail = CustEmail.text
            nextScreen.CustomerPhone = CustPhone.text
            nextScreen.CustomerAddress = CustAddress.text
            self.navigationController?.pushViewController(nextScreen, animated: true)
        

        }
    }*/

}







