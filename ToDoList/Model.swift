//
//  Model.swift
//  ToDoList
//
//  Created by Sysoev Anton on 26.07.2020.
//  Copyright © 2020 REALM. All rights reserved.
//

import UIKit

class ToDo {
    var UID: Int

    var name: String
    var date: Date
    var dateString: String {
        let df = DateFormatter()

        df.dateFormat = "dd.MM.yy H:mi"

        return df.string(from: date)
   }
    var isNotification: Bool

    init(name: String, date: Date, isNotification: Bool) {
        self.name = name
        self.date = date
        self.isNotification = isNotification

        UID = getNextUID()
    }

    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as! String
        self.date = dictionary["date"] as! Date
        self.isNotification = dictionary["isNotification"] as! Bool

        UID = dictionary["UID"] as! Int
    }

    func getDictionaryForSave() -> [String: Any] {
        let dict = ["name": name, "date": date, "isNotification": isNotification, "UID": UID] as [String: Any]

        return dict
    }
}

var dataArray: [ToDo] = []

func getNextUID() -> Int {
    var nextUID: Int = 0

    for todo in dataArray {
        if (todo.UID >= nextUID) {
            nextUID = todo.UID + 1
        }
    }

    return nextUID
}

func saveData() {
    var arrayForSave: [[String: Any]] = []

    for todo in dataArray {
        arrayForSave.append(todo.getDictionaryForSave())
    }

    UserDefaults.standard.set(arrayForSave, forKey: "data")
    UserDefaults.standard.synchronize()
}

func loadData() {
    let loadedDate = UserDefaults.standard.object(forKey: "data") as! [[String: Any]]?

    if let loaded = loadedDate {
        for dictionary in loaded {
            let todo = ToDo(dictionary: dictionary)

            dataArray.append(todo)
        }
    }
}

class Model: NSObject {

}
