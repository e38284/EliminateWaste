//
//  Food_2nd_ViewController.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2020/01/13.
//  Copyright © 2020 YutaroHagiwara. All rights reserved.
//

import UIKit
import RealmSwift

class Food_2nd_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    // MARK: - Instance
    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var energyContentLabel: UILabel!
    @IBOutlet weak var daylyAmountLabel: UILabel!
    
    var segmentWord = "" // Canine or Feline
    var dER = ""
    let realm = try! Realm()
    let sections  : [String] = ["Hills","ROYAL CANIN","JP Dietics"]
    var twoDimArray : [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Realm
        // Reflect initial data in TableView
        loadSeedRealm()
        
        // MARK: - UISearchBar
        // Customizing UISearchBar
        foodSearchBar.textField?.borderStyle = .none // No border (otherwise it will cover the original border)
        foodSearchBar.textField?.layer.borderWidth = 1 // Border thickness
        foodSearchBar.textField?.layer.cornerRadius = 8.0 // Rounded corners
        foodSearchBar.textField?.layer.masksToBounds = true // Mask TextField to fit round corners
        foodSearchBar.textField?.layer.borderColor = UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 0.5).cgColor // border color
        foodSearchBar.textField?.textColor = UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 1) // Change text color of UISearchBar
        // Change color of the magnifying glass icon
        foodSearchBar.textField?.lupeImageView?.becomeImageAlwaysTemplate()
        foodSearchBar.textField?.lupeImageView?.tintColor = UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 0.5)
        // Change color of placeholder(Asynchronous processing)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.foodSearchBar.textField?.attributedPlaceholder = NSAttributedString(
                string: "Please search for Food or Disease",
                attributes: [.foregroundColor: UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 0.5)]
            )
        }
        foodSearchBar.keyboardType = UIKeyboardType.default
        // Press return key even if nothing is entered in search bar
        foodSearchBar.enablesReturnKeyAutomatically = false
        
        // MARK: - UITableView
        // Erase extra Cell at the bottom of TableView
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - UISearchBar
    // Called before editing the SearchBar and activates the cancel button when editing starts
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    // Disable if cancel button is pressed and remove focus
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        self.tableView.reloadData()
    }
    // Call method when search button is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Close keyboard
         foodSearchBar.endEditing(true)
    }
    // Tap another location to close the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - UITableView関連
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    // Section title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(twoDimArray.count)
        return twoDimArray[section].count
    }
    // Set value in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Set the value to display in the cell
        cell.textLabel?.textColor = UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 1.0)
        cell.textLabel?.text = twoDimArray[indexPath.section][indexPath.row]
        return cell
    }
    // Change the text color of a section
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           let header = view as! UITableViewHeaderFooterView
           header.textLabel?.textColor = UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 1.0)
    }
    // Method called when Cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get text of tapped cell
        let tapCellText = twoDimArray[indexPath.section][indexPath.row]

        // Configuration of seed data
        let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "FoodList", withExtension: "realm"),readOnly: true)
        // Apply Configuration
        let realm = try! Realm(configuration: config)
        // Search for EnergyContent from realm using tapCellText
        let energyContent = realm.objects(FoodList.self).filter("productName == %@" , tapCellText)[0].energyContent
        energyContentLabel.text = String("\(energyContent)")
        //
        let daylyAmount : Double = atof(dER) / energyContent // DER/EnergyContent
        let daylyAmount_10 : Double = daylyAmount*10 // Multiply by 10 to shift the decimal point
        daylyAmountLabel.text = String("\(round(daylyAmount_10) / 10)") // Return decimal point after processing
        self.view.endEditing(true)
        
    }
    
    // MARK: - Realm
    // Call method when the text of Serchbar changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Empty the Array
        twoDimArray.removeAll()
        // Start search
        if foodSearchBar.text == "" {
            // Show all if Serchbar is empty。
            loadSeedRealm()
        } else {
            // Configuration of seed data
            let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "FoodList", withExtension: "realm"),readOnly: true)
            // Apply Configuration
            let realm = try! Realm(configuration: config)
            // Add section number
            for _ in 0 ... 2 {
                twoDimArray.append([])
            }
            // Search for species and manufacturer in realm (Separate variables for section)
            let hills = realm.objects(FoodList.self).filter("species == %@ AND manufacturer == 'Hills' " , segmentWord)
            let royalCanine = realm.objects(FoodList.self).filter("species == %@ AND manufacturer == 'ROYAL CANIN' " , segmentWord)
            let jp = realm.objects(FoodList.self).filter("species == %@ AND manufacturer == 'JP Dietics' " , segmentWord)
            // Search realm for SearchWord included in ProductName and DiseaseClassification
            let hills2 = hills.filter("productName CONTAINS %@ OR diseaseClassification_1 CONTAINS  %@ OR diseaseClassification_2 CONTAINS  %@ OR diseaseClassification_3 CONTAINS  %@ " ,foodSearchBar.text!,foodSearchBar.text!,foodSearchBar.text!,foodSearchBar.text!)
            let royalCanine2 = royalCanine.filter("productName CONTAINS  %@ OR diseaseClassification_1 CONTAINS  %@ OR diseaseClassification_2 CONTAINS  %@ OR diseaseClassification_3 CONTAINS  %@ " , foodSearchBar.text!,foodSearchBar.text!,foodSearchBar.text!,foodSearchBar.text!)
            let jp2 = jp.filter("productName CONTAINS  %@ OR diseaseClassification_1 CONTAINS  %@ OR diseaseClassification_2 CONTAINS  %@ OR diseaseClassification_3 CONTAINS  %@ " , foodSearchBar.text!,foodSearchBar.text!,foodSearchBar.text!,foodSearchBar.text!)
            // Add search result to array
            for i in 0 ..< hills2.count {
                twoDimArray[0].append(hills2[i].productName)
            }
            for i in 0 ..< royalCanine2.count {
                twoDimArray[1].append(royalCanine2[i].productName)
            }
            for i in 0 ..< jp2.count {
                twoDimArray[2].append(jp2[i].productName)
            }
        }
        // Reload the TableView
        tableView.reloadData()
    }
    // Creating initial data
    func loadSeedRealm(){
        // // Configuration of seed data
        let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "FoodList", withExtension: "realm"),readOnly: true)
        // Apply Configuration
        let realm = try! Realm(configuration: config)
        // Add section number
        for _ in 0 ... 2 {
            twoDimArray.append([])
        }
        // Search for species and manufacturer in realm (Separate variables for section)
        let hills = realm.objects(FoodList.self).filter("species == %@ AND manufacturer == 'Hills' " , segmentWord)
        let royalCanine = realm.objects(FoodList.self).filter("species == %@ AND manufacturer == 'ROYAL CANIN' " , segmentWord)
        let jp = realm.objects(FoodList.self).filter("species == %@ AND manufacturer == 'JP Dietics' " , segmentWord)
        // Add search result to array
        for i in 0 ..< hills.count {
            twoDimArray[0].append(hills[i].productName)
        }
        for i in 0 ..< royalCanine.count {
            twoDimArray[1].append(royalCanine[i].productName)
        }
        for i in 0 ..< jp.count {
            twoDimArray[2].append(jp[i].productName)
        }
        // Reload the TableView
        tableView.reloadData()
    }
}
     
