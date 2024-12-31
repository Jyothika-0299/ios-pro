//
//  ViewController.swift
//  VIP_1
//
//  Created by FCI on 21/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var customerRegisterLabel: UILabel!
    @IBOutlet weak var customerIDLabel: UILabel!
    @IBOutlet weak var customerIDTextField: UITextField!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var customerPhoneLabel: UILabel!
    @IBOutlet weak var customerPhoneTextField: UITextField!
    @IBOutlet weak var customerEmailLabel: UILabel!
    @IBOutlet weak var customerEmailTextField: UITextField!
    @IBOutlet weak var customerAddressLabel: UILabel!
    @IBOutlet weak var customerAddressTextField: UITextField!
    //@IBOutlet weak var customerCityTextField: UITextField!
    //@IBOutlet weak var customerCountryTextField: UITextField!
    //@IBOutlet weak var customerPincodeTextField: UITextField!
    //@IBOutlet weak var customerStateTextField: UITextField!
    @IBOutlet weak var ProceedLabel: UILabel!
    @IBOutlet weak var SubmitLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.isEnabled = false
    }
    
    
    // MARK: - Actions
    @IBAction func textFieldEditingChanged(_ sender: UIButton) {
        validateForm()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        print("Customer Registered!")
        print("ID: \(customerIDTextField.text ?? "")")
        print("Name: \(customerNameTextField.text ?? "")")
        print("Phone: \(customerPhoneTextField.text ?? "")")
        print("Email: \(customerEmailTextField.text ?? "")")
        print("Address: \(customerAddressTextField.text ?? "")")
        
        
        
        
    }
    
    // MARK: - Validation
    private func validateForm() {
        let isFormValid = !(customerIDTextField.text?.isEmpty ?? true) &&
        !(customerNameTextField.text?.isEmpty ?? true) && isValidid(customerIDTextField.text) &&
                        isValidName(customerNameTextField.text!) &&
                        (customerPhoneTextField.text?.count ?? 0) >= 10 &&
                          isValidEmail(customerEmailTextField.text)
        
        submitButton.isEnabled = isFormValid
        submitButton.backgroundColor = isFormValid ? .systemBlue : .gray
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    private func isValidid(_ id : String?) -> Bool {
        guard let id = id else { return false }
        let idRegex = "^[0-9]{3,10}$" // Numeric, 3–10 characters
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
        return idPredicate.evaluate(with: id)
    }
   private func isValidName(_ name: String) -> Bool {
            let nameRegex = "^[a-zA-Z ]{2,50}$" // Alphabetic, spaces allowed, 2–50 characters
            let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            return namePredicate.evaluate(with: name)
        }
        

}
