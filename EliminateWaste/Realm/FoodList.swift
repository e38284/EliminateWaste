//
//  FoodList.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2020/01/21.
//  Copyright © 2020 YutaroHagiwara. All rights reserved.
//
import Foundation
import RealmSwift

class FoodList: Object, Codable  {
    @objc dynamic var id = 0
    @objc dynamic var productName = "" // TestTimeの`id`
    @objc dynamic var species = "" // Sectionの`id`
    @objc dynamic var manufacturer = "" // 問題番号
    @objc dynamic var energyContent = 0.0 //問題文
    @objc dynamic var diseaseClassification_1 = "" // 回答の選択肢番号
    @objc dynamic var diseaseClassification_2 = "" //回答数のタイプ
    @objc dynamic var diseaseClassification_3 = "" // 正しいものを選べor誤りを選べ
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
