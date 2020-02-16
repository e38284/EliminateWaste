//
//  Food_1st_ViewController.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2019/12/20.
//  Copyright © 2019 YutaroHagiwara. All rights reserved.
//

import UIKit
import RealmSwift


@IBDesignable
class Food_1st_ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Instance
    @IBOutlet weak var speciesSegment: UISegmentedControl!
    @IBOutlet weak var bodyWeight: UITextField!
    @IBOutlet weak var coefficient: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var coefficientButton: UIButton!
    @IBOutlet weak var rERButton: UIButton!
    @IBOutlet weak var dERButton: UIButton!
    @IBOutlet weak var rER: UILabel!
    @IBOutlet weak var dER: UILabel!
    var pickerView = UIPickerView()
    var coefficientElement : [String] = ["1.0", "1.4", "1.6", "2.0", "2.5", "3.0"]
    var segmentWord = "canine" // Word selected in SegmentedControl
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - NavigationBar
        // Change text in navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [
        // Change text color
            .foregroundColor: UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 1)
        ]
        // Hide UINavigationBar back button text(NextViewController)
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        // MARK: - SegmentedControl
        // Change text in segment control
        speciesSegment.setTitleTextAttributes(
            // Change text color
            [NSAttributedString.Key.foregroundColor:UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 1)
            ], for: .normal
        )
        // Set the method to be called when the segment changes
        speciesSegment.addTarget(self, action: #selector(segmentChanged(_:)), for: UIControl.Event.valueChanged)
        
        // MARK: - TextField
        bodyWeight.delegate = self
        // Put the "Done" button on the keyboard
        let toolbarTextField = UIToolbar()
        let spaceTextField = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneTextField = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(enterBodyWeight))
        toolbarTextField.items = [spaceTextField, doneTextField]
        toolbarTextField.sizeToFit()
        bodyWeight.inputAccessoryView = toolbarTextField
        // Numeric keyboard (with decimal point)
        bodyWeight.keyboardType = UIKeyboardType.decimalPad
        // Identify Placeholder, change to 17-size system font
        let bodyWeightPlaceholder = bodyWeight?.value(forKey: "placeholderLabel") as? UILabel
        bodyWeightPlaceholder?.font = .systemFont(ofSize: 17)
        
        // MARK: - UIButton
        nextButton.isEnabled = true
        // When UIButton is pressed, specify background color with UIColor
        let blueColor = UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 1)
        let whiteColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        coefficientButton.setBackgroundColor(blueColor , for: .highlighted)
        rERButton.setBackgroundColor(whiteColor , for: .highlighted)
        dERButton.setBackgroundColor(whiteColor , for: .highlighted)
      
        // MARK: - PickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        // First selected row
        pickerView.selectRow(2, inComponent: 0, animated: false)
        self.coefficient.inputView = pickerView
    }
    
    // MARK: - SegmentedControl
    // Method called when segment changes
    @objc func segmentChanged(_ segment:UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0 :
            segmentWord = "canine"
            coefficientElement = ["1.0", "1.4", "1.6", "2.0", "2.5", "3.0"]
            bodyWeight.text = "5.0"
            coefficient.text = coefficientElement[2]
            rER.text = "234.1"
            dER.text = "374.5"
            pickerView.selectRow(2, inComponent: 0, animated: false)
            nextButton.isEnabled = true
        case 1 :
            segmentWord = "feline"
            coefficientElement = ["0.8", "1.0", "1.1", "1.2", "2.0", "2.5", "3.0"]
            bodyWeight.text = "3.0"
            coefficient.text = coefficientElement[3]
            rER.text = "159.5"
            dER.text = "191.4"
            pickerView.selectRow(3, inComponent: 0, animated: false)
            nextButton.isEnabled = true
        default:
            break
        }
    }
    
    // MARK: - TextField
    // When the text field has focus
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Empty text field
        bodyWeight.text = ""
    }
    // Tap another location to close the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        enterBodyWeight()
        self.view.endEditing(true)
    }
    // Press the enter "Done" in the text field or Tap another location
    @objc func enterBodyWeight() {
        // Change label when text field is updated
        if bodyWeight.text != "" {
            // Create RER
            let bodyWeightString = bodyWeight.text
            let bodyWeightDouble : Double = atof(bodyWeightString) // String → Double
            let Exponentiation : Double  = 0.75
            let rERDouble : Double = pow(bodyWeightDouble, Exponentiation)*70 // pow(X,Y) = X^Y
            let rERDouble_10 : Double = rERDouble*10 // Multiply by 10 to shift the decimal point
            rER.text = String("\(round(rERDouble_10) / 10)") // Return decimal point after processing
            // Create DER
            let dERDouble : Double = atof(rER.text) * atof(coefficient.text) // RER*coefficient
            let dERDouble_10 : Double = dERDouble*10 // Multiply by 10 to shift the decimal point
            dER.text = String("\(round(dERDouble_10) / 10)") // Return decimal point after processing
            nextButton.isEnabled = true
        } else {
            rER.text = ""
            dER.text = ""
            nextButton.isEnabled = false
        }
        // Close the text field keyboard
        bodyWeight.resignFirstResponder()
    }
    // When pickerView row is selected
    @objc func enterCoefficient() {
        enterBodyWeight()
        // Change label when text field is updated
        if bodyWeight.text != "" {
            let dERDouble : Double = atof(rER.text) * atof(coefficient.text) // RER*coefficient
            let dERDouble_10 : Double = dERDouble*10 // Multiply by 10 to shift the decimal point
            // Rounded to one decimal place
            dER.text = String("\(round(dERDouble_10) / 10)") // Return decimal point after processing
        } else {
            nothingRERAlert()
        }
    }
    
    // MARK: - PickerView
    // Number of drum rolls
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Number of rows in one drum roll
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coefficientElement.count
    }
    // Row title in drum roll
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coefficientElement[row]
    }
    // When a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coefficient.text = coefficientElement[row]
        // Change label when text field is updated
        enterCoefficient()
        self.view.endEditing(true)
    }
    
    // MARK: - Segue
    // Method called before Segue is executed
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // Get the segue destination ViewController
        if segue.identifier == "toFood2ndVC" {
            let food2ndVC = segue.destination as! Food_2nd_ViewController
            // Pass SegmentWord to SegueVC
            food2ndVC.segmentWord = segmentWord
            food2ndVC.dER = dER.text!
        }
        
    // MARK: - UIPopoverPresentationController
        // Get the segue popover destination
        let popoverCtrl = segue.destination.popoverPresentationController
        // When the caller is a UIButton
        if sender is UIButton {
            // Get the area of ​​the tapped button
            popoverCtrl?.sourceRect = (sender as! UIButton).bounds
        }
        // Get the segue destination ViewController
        if segue.identifier == "toCoefficientVC" {
            let coefficientVC = segue.destination as! CoefficientViewController
            // Specify the direction in which the arrow appears
            coefficientVC.popoverPresentationController?.permittedArrowDirections = .up
            // Pass SegmentWord to SegueVC
            coefficientVC.segmentWord = segmentWord
        }
        if segue.identifier == "toRER_DERVC" {
            let rER_dERVC = segue.destination as! RER_DERViewController
            // Specify the direction in which the arrow appears
            rER_dERVC.popoverPresentationController?.permittedArrowDirections = .down
        }
        // Set delegate to yourself
        popoverCtrl?.delegate = self
    }
    // Display style settings
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // By setting ".none", it will be popped over at the set size
        return .none
    }
    
    // MARK: - AlertController
    // Method to display alert
    func nothingRERAlert() {
        // Set title, message,and alert styles
        let alert: UIAlertController = UIAlertController(title: "Alert", message: "BodyWeight is not entered…!", preferredStyle: UIAlertController.Style.alert)
        // Ok button setting
        let okAction: UIAlertAction = UIAlertAction(title: "Ok!", style: UIAlertAction.Style.cancel, handler:{
            // Write the process when the button is pressed (closure implementation)
            (action: UIAlertAction!) -> Void in
            self.dER.text = ""
            print("Ok!")
        })
        // Add Action to UIAlertController
        alert.addAction(okAction)
        // Show Alert
        present(alert, animated: true, completion: nil)
    }
}
