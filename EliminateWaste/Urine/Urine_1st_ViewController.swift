//
//  Urine_1st_ViewController.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2020/02/05.
//  Copyright © 2020 YutaroHagiwara. All rights reserved.
//

import UIKit
import Eureka

class Urine_1st_ViewController: FormViewController {

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
        // Do any additional setup after loading the view.
        
        // MARK: - Eureka
        form
            
        +++ Section()
        <<< TextRow { row in
            row.title = "Name"
            row.placeholder = "Enter the patient name"
        }
        <<< DateRow(){
            $0.title = "Date"
            $0.value = Date()
        }
        <<< ActionSheetRow<String>("Method") {
            $0.title = "Method"
            $0.selectorTitle = "Please select a urine collection method"
            $0.options = ["Nature","Compression","Catheter","Puncture"]
            $0.value = "Nature"
        }.onChange{row in
//            print(row.value as Any)
        }
            
        +++ Section("Physical")
        <<< ActionSheetRow<String>("Color") {
            $0.title = "Color"
            $0.selectorTitle = "Please select a color"
            $0.options = ["Yellow","Orange","red"]
            $0.value = "Yellow"
        }.onChange{row in

        }
        <<< SegmentedRow<String>("Cloudiness"){
            $0.options = ["Cleanness", "Cloudiness"]
            $0.value = "Cleanness"
        }.onChange{ row in
    
        }
        
        +++ Section("Chemical")
        <<< ActionSheetRow<String>("Glu") {
            $0.title = "Glu"
//            $0.selectorTitle = "Please select a color"
            $0.options = ["ー","± (50)","1+ (100)","2+ (200)","3+ (500)","4+ (1000)"]
            $0.value = "ー"
        }.onChange{row in

        }
        <<< ActionSheetRow<String>("TP") {
            $0.title = "TP"
            $0.options = ["ー","± (15)","1+ (30)","2+ (100)","3+ (300)","4+ (1000)"]
            $0.value = "ー"
        }.onChange{row in

        }
        <<< ActionSheetRow<String>("Bill") {
            $0.title = "Bill"
            $0.options = ["ー","1+ (0.5)","2+ (2.0)","3+ (6.0)","4+ (Over)"]
            $0.value = "ー"
        }.onChange{row in

        }
        <<< ActionSheetRow<String>("Uro") {
            $0.title = "Uro"
            $0.options = ["ー","1+ (2.0)","2+ (4.0)","3+ (8.0)","4+ (Over)"]
            $0.value = "ー"
        }.onChange{row in

        }
        <<< ActionSheetRow<String>("pH") {
            $0.title = "pH"
            $0.options = ["5.0","6.0","7.0","8.0","9.0"]
            $0.value = "7.0"
        }.onChange{row in

        }
        <<< DecimalRow(){
            $0.useFormatterDuringInput = true
            $0.title = "S.G"
            $0.value = 1.030
            let formatter = DecimalFormatter()
            formatter.locale = .current
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 3
            formatter.maximumFractionDigits = 3
            $0.formatter = formatter
        }
        <<< ActionSheetRow<String>("Bld") {
            $0.title = "Bld"
            $0.options = ["ー","± (0.03)","1+ (0.06)","2+ (0.20)","3+ (1.00)","非溶血 1+"]
            $0.value = "ー"
        }.onChange{row in

        }
        <<< ActionSheetRow<String>("Ket") {
            $0.title = "Ket"
            $0.options = ["ー"," ± ","1+ (15)","2+ (40)","3+ (80)","4+ (150)"]
            $0.value = "ー"
        }.onChange{row in

        }
        <<< ActionSheetRow<String>("Nit") {
            $0.title = "Nit"
            $0.options = ["ー","1+","2+"]
            $0.value = "ー"
        }.onChange{row in

        }
        <<< ActionSheetRow<String>("Leu") {
            $0.title = "Leu"
            $0.options = ["ー","25","75","250","500"]
            $0.value = "ー"
        }.onChange{row in

        }
        
        +++ Section("Sediment")
        <<< MultipleSelectorRow<String>("Cell") {
            $0.title = "Cell"
            $0.options = ["RBC","WBC","移行上皮細胞","扁平上皮細胞"]
        }.onChange{row in

        }
        <<< MultipleSelectorRow<String>("UrineCast & Bac") {
            $0.title = "UrineCast & Bac"
            $0.options = ["硝子円柱","顆粒円柱","蝋様円柱","細胞円柱","球菌","桿菌"]
        }.onChange{row in

        }
        <<< MultipleSelectorRow<String>("Crystal") {
            $0.title = "Crystal"
            $0.options = ["無晶性塩類","リン酸アンモニウムマグネシウム","シュウ酸カルシウム","リン酸カルシウム","尿酸アンモニウム","ビリルビン結晶","シスチン結晶"]
        }.onChange{row in

        }
        <<< TextRow { row in
            row.title = "Other"
            row.placeholder = "Please write any other observations"
        }
    }
}
