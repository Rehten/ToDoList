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
    var isNotification: Bool

    init(name: String, date: Date, isNotification: Bool) {
        self.name = name
        self.date = date
        self.isNotification = isNotification

        UID = getNextUID()
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

class Model: NSObject {

}
