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
    @IBOutlet var ExistingBtn: UIButton!
    
    var customerData: [String: String] = [:] // To store validated/retrieved data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NextBtn.isEnabled = false
    }
    
    // MARK: - Save Button Action
    @IBAction func ClickSave(_ sender: UIButton) {
        validateForm()
        if NextBtn.isEnabled {
            showAlert(title: "Success", message: "Form is valid. You can now navigate to the next screen.")
        }
    }
    
    
    
    
    var hasNavigatedToTabBar = false // Add this property to your ViewController class

    @IBAction func ClickNext(_ sender: UIButton) {
        // Prevent multiple navigations
        guard !hasNavigatedToTabBar else {
            print("Navigation to TabBar already happened.")
            return
        }
        hasNavigatedToTabBar = true

        // Fetch data from text fields
        let ID = CustID.text ?? ""
        let Name = CustName.text ?? ""
        let Phone = CustPhone.text ?? ""
        let Email = CustEmail.text ?? ""
        let Address = CustAddress.text ?? ""

        // Validate that required fields are not empty
        guard !ID.isEmpty, !Name.isEmpty, !Phone.isEmpty, !Email.isEmpty, !Address.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            hasNavigatedToTabBar = false // Allow retrying
            return
        }

        // Prepare customer data as a list of values
        let customerValues = [ID, Name, Phone, Email, Address]

        // Instantiate TabBarController
        if let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "storyid1") as? UITabBarController {
            
            // Pass data to the first tab (Home screen)
            if let viewControllers = tabBarController.viewControllers {
                for vc in viewControllers {
                    if let menuVC = vc as? menuViewController {
                        menuVC.customerValues = customerValues // Pass the list of values
                    }
                }
            }
            
            // Ensure Home tab is selected
            tabBarController.selectedIndex = 0
            
            // Navigate to the TabBarController
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }


    // MARK: - Existing User Button Action
    @IBAction func ClickExistingUser(_ sender: UIButton) {
        guard let ID = CustID.text, !ID.isEmpty else {
            showAlert(title: "Error", message: "No Customer Found")
            return
        }
        
        guard let webserviceURL = URL(string: "https://abzcustomerwebapi-chana.azurewebsites.net/api/Customer/\(ID)") else {
            showAlert(title: "Error", message: "Invalid URL")
            return
        }
        
        var request = URLRequest(url: webserviceURL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(title: "Error", message: "Request failed: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    self.showAlert(title: "Error", message: "Server error: \(httpResponse.statusCode)")
                    return
                }
                
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            self.populateForm(with: jsonResponse)
                            self.showAlert(title: "Success", message: "Details found successfully.")
                        }
                    } catch {
                        self.showAlert(title: "Error", message: "Failed to parse JSON: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
    
    // MARK: - Helper Methods
    private func validateForm() {
        let isFormValid = !(CustID.text?.isEmpty ?? true) &&
            isValidID(CustID.text) &&
            !(CustName.text?.isEmpty ?? true) &&
            isValidName(CustName.text ?? "") &&
            !(CustPhone.text?.isEmpty ?? true) &&
            (CustPhone.text?.count ?? 0) >= 10 &&
            isValidEmail(CustEmail.text) &&
            !(CustAddress.text?.isEmpty ?? true)
        
        if isFormValid {
            // Collect customer data
            customerData = [
                "CustomerID": CustID.text ?? "",
                "CustomerName": CustName.text ?? "",
                "CustomerPhone": CustPhone.text ?? "",
                "CustomerEmail": CustEmail.text ?? "",
                "CustomerAddress": CustAddress.text ?? ""
            ]
        }
        
        NextBtn.isEnabled = isFormValid
        NextBtn.backgroundColor = isFormValid ? .systemBlue : .gray
    }
    
    private func populateForm(with data: [String: Any]) {
        CustName.text = data["customerName"] as? String ?? ""
        CustPhone.text = data["customerPhone"] as? String ?? ""
        CustEmail.text = data["customerEmail"] as? String ?? ""
        CustAddress.text = data["customerAddress"] as? String ?? ""
        validateForm()
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    private func isValidID(_ id: String?) -> Bool {
        guard let id = id else { return false }
        return NSPredicate(format: "SELF MATCHES %@", "^[0-9]{3,10}$").evaluate(with: id)
    }
    
    private func isValidName(_ name: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z ]{2,50}$").evaluate(with: name)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
