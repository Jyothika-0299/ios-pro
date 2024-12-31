//
//  ViewController.swift
//  VEHDIS
//
//  Created by FCI on 30/12/24.
//
/*
import UIKit

class ViewController: UIViewController {
    @IBOutlet var l1:UILabel!
    @IBOutlet var l2:UILabel!
    @IBOutlet var l3:UILabel!
    @IBOutlet var l4:UILabel!
    @IBOutlet var l5:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getVehicles()
    }
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                    }
                }
                return
            }
            
            print("Getting the Response")
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print("Response: \(jsonResponse)")
                        
                        // Collect all vehicle IDs
                        var vehicleIDs: [String] = []
                        for vehicle in jsonResponse {
                            if let vehicleID = vehicle["regNo"] as? String {
                                print("Vehicle ID: \(vehicleID)")
                                vehicleIDs.append(vehicleID)
                            } else {
                                print("regNo not found for vehicle: \(vehicle)")
                            }
                        }
                        
                        // Update the UI on the main thread
                        DispatchQueue.main.async {
                            self.l1.text = vehicleIDs.joined(separator: "\n")
                        }
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
*/
/*
//
//  ViewController.swift
//  VEHDIS
//
//  Created by FCI on 30/12/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var l1: UILabel! // regno
    @IBOutlet var l2: UILabel! // engineno
    @IBOutlet var l3: UILabel! // chassisno
    @IBOutlet var l4: UILabel! // make
    @IBOutlet var l5: UILabel! // model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch vehicle data
        getVehicles()
        
    }
    
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/ByCustomer/6767")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                    }
                }
                return
            }
            
            print("Getting the Response")
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print("Response: \(jsonResponse)")
                        
                        // Assuming the API returns a single vehicle for now (can be adjusted for multiple vehicles)
                        if let firstVehicle = jsonResponse.first {
                            let regNo = firstVehicle["regNo"] as? String ?? "N/A"
                            let engineNo = firstVehicle["engineNo"] as? String ?? "N/A"
                            let chassisNo = firstVehicle["chassisNo"] as? String ?? "N/A"
                            let make = firstVehicle["make"] as? String ?? "N/A"
                            let model = firstVehicle["model"] as? String ?? "N/A"
                            
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                self.l1.text = regNo
                                self.l2.text = engineNo
                                self.l3.text = chassisNo
                                self.l4.text = make
                                self.l5.text = model
                            }
                        } else {
                            print("No vehicles found in response")
                        }
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    
    
    
}
*/

/*

import UIKit

class ViewController: UIViewController {
    @IBOutlet var l1: UILabel! // regno
    @IBOutlet var l2: UILabel! // engineno
    @IBOutlet var l3: UILabel! // chassisno
    @IBOutlet var l4: UILabel! // make
    @IBOutlet var l5: UILabel! // model

    var customersList: [[String: Any]] = [] // To store customer data
    var vehiclesList: [[String: Any]] = []  // To store vehicle data

    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch vehicle and customer data
        getCustomers()
        getVehicles()
    }
    
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/ByCustomer/6767")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        self.vehiclesList = jsonResponse
                        print("Vehicles List: \(self.vehiclesList)")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func getCustomers() {
        let url = URL(string: "https://abzcustomerwebapi-chana.azurewebsites.net/api/Customer")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        self.customersList = jsonResponse
                        print("Customers List: \(self.customersList)")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func displayCustomerVehicleDetails(customerID: String) {
        // Find the vehicle associated with the given customerID
        if let vehicle = vehiclesList.first(where: { $0["customerID"] as? String == customerID }) {
            let regNo = vehicle["regNo"] as? String ?? "N/A"
            let engineNo = vehicle["engineNo"] as? String ?? "N/A"
            let chassisNo = vehicle["chassisNo"] as? String ?? "N/A"
            let make = vehicle["make"] as? String ?? "N/A"
            let model = vehicle["model"] as? String ?? "N/A"
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.l1.text = regNo
                self.l2.text = engineNo
                self.l3.text = chassisNo
                self.l4.text = make
                self.l5.text = model
            }
        } else {
            print("No vehicle found for customerID: \(customerID)")
        }
    }
}
*/

/*
import UIKit

class ViewController: UIViewController {
    @IBOutlet var l1: UILabel! // regno
    @IBOutlet var l2: UILabel! // engineno
    @IBOutlet var l3: UILabel! // chassisno
    @IBOutlet var l4: UILabel! // make
    @IBOutlet var l5: UILabel! // model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch vehicle data
        getVehicles()
    }
    
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/ByCustomer/6767")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                    }
                }
                return
            }
            
            print("Getting the Response")
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print("Response: \(jsonResponse)")
                        
                        // Initialize empty strings for each field
                        var regNos = [String]()
                        var engineNos = [String]()
                        var chassisNos = [String]()
                        var makes = [String]()
                        var models = [String]()
                        
                        // Iterate over the vehicles and collect their details
                        for vehicle in jsonResponse {
                            regNos.append(vehicle["regNo"] as? String ?? "N/A")
                            engineNos.append(vehicle["engineNo"] as? String ?? "N/A")
                            chassisNos.append(vehicle["chassisNo"] as? String ?? "N/A")
                            makes.append(vehicle["make"] as? String ?? "N/A")
                            models.append(vehicle["model"] as? String ?? "N/A")
                        }
                        
                        // Update the UI on the main thread
                        DispatchQueue.main.async {
                            self.l1.text = regNos.joined(separator: "\n")
                            self.l2.text = engineNos.joined(separator: "\n")
                            self.l3.text = chassisNos.joined(separator: "\n")
                            self.l4.text = makes.joined(separator: "\n")
                            self.l5.text = models.joined(separator: "\n")
                        }
                    } else {
                        print("No vehicles found in response")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
*/
/*
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView! // Connect this to the UITableView in your storyboard
    
    var vehicles: [[String: String]] = [] // Array to store vehicle data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Fetch vehicle data
        getVehicles()
    }
    
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/ByCustomer/6767")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                    }
                }
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        // Map the JSON response to the vehicles array
                        self.vehicles = jsonResponse.map { vehicle in
                            [
                                "regNo": vehicle["regNo"] as? String ?? "N/A",
                                "engineNo": vehicle["engineNo"] as? String ?? "N/A",
                                "chassisNo": vehicle["chassisNo"] as? String ?? "N/A",
                                "make": vehicle["make"] as? String ?? "N/A",
                                "model": vehicle["model"] as? String ?? "N/A"
                            ]
                        }
                        
                        // Reload the table view on the main thread
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        print("No vehicles found in response")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - UITableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath)
        
        // Configure the cell with vehicle data
        let vehicle = vehicles[indexPath.row]
        cell.textLabel?.text = """
        Reg No: \(vehicle["regNo"] ?? "N/A")
        Engine No: \(vehicle["engineNo"] ?? "N/A")
        Chassis No: \(vehicle["chassisNo"] ?? "N/A")
        Make: \(vehicle["make"] ?? "N/A")
        Model: \(vehicle["model"] ?? "N/A")
        """
        cell.textLabel?.numberOfLines = 0 // Allow multi-line display
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Vehicle Details"
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //7.height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
}

*/
/*
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView! // Connect this to the UITableView in your storyboard
    
    var vehicles: [[String: String]] = [] // Array to store vehicle data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Fetch vehicle data
        getVehicles()
    }
    
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/ByCustomer/6767")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                    }
                }
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        // Map the JSON response to the vehicles array
                        self.vehicles = jsonResponse.map { vehicle in
                            [
                                "regNo": vehicle["regNo"] as? String ?? "N/A",
                                "engineNo": vehicle["engineNo"] as? String ?? "N/A",
                                "chassisNo": vehicle["chassisNo"] as? String ?? "N/A",
                                "make": vehicle["make"] as? String ?? "N/A",
                                "model": vehicle["model"] as? String ?? "N/A"
                            ]
                        }
                        
                        // Reload the table view on the main thread
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        print("No vehicles found in response")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - UITableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath)
        
        // Configure the cell with vehicle data
        let vehicle = vehicles[indexPath.row]
        cell.textLabel?.text = """
        Reg No: \(vehicle["regNo"] ?? "N/A")
        Engine No: \(vehicle["engineNo"] ?? "N/A")
        Chassis No: \(vehicle["chassisNo"] ?? "N/A")
        Make: \(vehicle["make"] ?? "N/A")
        Model: \(vehicle["model"] ?? "N/A")
        """
        cell.textLabel?.numberOfLines = 0 // Allow multi-line display
        cell.accessoryType = .disclosureIndicator // Add accessory button
        
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection if needed
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Create and navigate to the new view controller
        let vehicle = vehicles[indexPath.row]
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! PolicyViewController
        
        // Pass vehicle details to the new view controller
        //detailsVC.vehicleDetails = vehicle
        
        // Push the new view controller
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
*/
/*
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView! // Connect this to the UITableView in your storyboard
    
    var vehicles: [[String: String]] = [] // Array to store vehicle data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Fetch vehicle data
        getVehicles()
    }
    
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/ByCustomer/6767")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                    }
                }
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        // Map the JSON response to the vehicles array
                        self.vehicles = jsonResponse.map { vehicle in
                            [
                                "regNo": vehicle["regNo"] as? String ?? "N/A",
                                "engineNo": vehicle["engineNo"] as? String ?? "N/A",
                                "chassisNo": vehicle["chassisNo"] as? String ?? "N/A",
                                "make": vehicle["make"] as? String ?? "N/A",
                                "model": vehicle["model"] as? String ?? "N/A"
                            ]
                        }
                        
                        // Reload the table view on the main thread
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        print("No vehicles found in response")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - UITableView DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Vehicle Details"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // Reg No, Engine No, Chassis No, Make, Model
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath)
        
        // Configure the cell based on the row index
        let vehicle = vehicles[indexPath.section]
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Reg No: \(vehicle["regNo"] ?? "N/A")"
        case 1:
            cell.textLabel?.text = "Engine No: \(vehicle["engineNo"] ?? "N/A")"
        case 2:
            cell.textLabel?.text = "Chassis No: \(vehicle["chassisNo"] ?? "N/A")"
        case 3:
            cell.textLabel?.text = "Make: \(vehicle["make"] ?? "N/A")"
        case 4:
            cell.textLabel?.text = "Model: \(vehicle["model"] ?? "N/A")"
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

*/
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView! // Connect this to the UITableView in your storyboard
    
    var vehicles: [[String: String]] = [] // Array to store vehicle data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Fetch vehicle data
        getVehicles()
    }
    
    func getVehicles() {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJlZSIsImV4cCI6MTczNTU1NDAzNSwiaXNzIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIiwiYXVkIjoiaHR0cHM6Ly93d3cudGVhbTEuY29tIn0.N2puPaRWtrKVWu1FrxSMjkGnO8CV92xtgPmKaAZysV4"
        
        // Create the URL Request
        let url = URL(string: "https://abzvehiclewebapi-chanad.azurewebsites.net/api/Vehicle/ByCustomer/6767")! // Replace with your API URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the API Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                    }
                }
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        // Map the JSON response to the vehicles array
                        self.vehicles = jsonResponse.map { vehicle in
                            [
                                "regNo": vehicle["regNo"] as? String ?? "N/A",
                                "engineNo": vehicle["engineNo"] as? String ?? "N/A",
                                "chassisNo": vehicle["chassisNo"] as? String ?? "N/A",
                                "make": vehicle["make"] as? String ?? "N/A",
                                "model": vehicle["model"] as? String ?? "N/A"
                            ]
                        }
                        
                        // Reload the table view on the main thread
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        print("No vehicles found in response")
                    }
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - UITableView DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Vehicle Details"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // Reg No, Engine No, Chassis No, Make, Model
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath)
        
        // Configure the cell based on the row index
        let vehicle = vehicles[indexPath.section]
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Reg No: \(vehicle["regNo"] ?? "N/A")"
        case 1:
            cell.textLabel?.text = "Engine No: \(vehicle["engineNo"] ?? "N/A")"
        case 2:
            cell.textLabel?.text = "Chassis No: \(vehicle["chassisNo"] ?? "N/A")"
        case 3:
            cell.textLabel?.text = "Make: \(vehicle["make"] ?? "N/A")"
        case 4:
            cell.textLabel?.text = "Model: \(vehicle["model"] ?? "N/A")"
        default:
            cell.textLabel?.text = ""
        }
        
        // Add an accessory button
        //cell.accessoryType = .detailButton
        
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {

            return "Vehicle details end"
        }
    /*
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Navigate to the next view controller
        let vehicle = vehicles[indexPath.section]
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! PolicyViewController
        
        // Pass vehicle details to the next view controller
        detailsVC.vehicleDetails = vehicle
        
        // Push the new view controller
        navigationController?.pushViewController(detailsVC, animated: true)
    }
     */
}
