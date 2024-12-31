//
//  OverallViewController.swift
//  INS_APP
//
//  Created by FCI on 30/12/24.
//

import UIKit

class OverallViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView! // Connect this to the UITableView in your storyboard
    @IBOutlet var l1: UILabel!
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
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZGQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJld2UiLCJleHAiOjE3MzU2NDQ5MTcsImlzcyI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3LnRlYW0xLmNvbSJ9.oDiC-aM-hYtKDbqI8CP_J-KZqYt9nJPgJhuib0dtFZw"
        
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
                                "regDate": vehicle["regDate"] as? String ?? "N/A",
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
            cell.textLabel?.text = "Reg_Date: \(vehicle["regDate"] ?? "N/A")"
        case 4:
            cell.textLabel?.text = "Model: \(vehicle["model"] ?? "N/A")"
        default:
            cell.textLabel?.text = ""
        }
        
        // Add an accessory button
        //cell.accessoryType = .detailButton
        cell.tintColor = .black
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            return "Vehicle details end"
        }
    //6.height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //7.height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
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
