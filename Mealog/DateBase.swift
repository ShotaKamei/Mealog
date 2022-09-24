//
//  DateBase.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/24.
//

import Foundation
import RealmSwift

class User: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var caption: String = ""
    @objc dynamic var rate: Int = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var locate: String = ""
    @objc dynamic var latitude: Float = 0.0
    @objc dynamic var longitude: Float = 0.0
    let photo = List<Photos>()
    let category = List<Categorys>()
}

class Photos: Object{
    @objc dynamic var photo: String = ""
}

class Categorys: Object{
    @objc dynamic var category: String = ""
}

class Candidate: Object{
    @objc dynamic var category: String = ""
    override static func primaryKey() -> String? {
            return "category"
    }
}
