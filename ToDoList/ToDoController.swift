//
//  ToDoController.swift
//  ToDoList
//
//  Created by Sysoev Anton on 26.07.2020.
//  Copyright © 2020 REALM. All rights reserved.
//

import UIKit
import UserNotifications

class ToDoController: UIViewController {
    var todo: ToDo?

    @IBOutlet weak var textField: UITextField!
    @IBAction func textChangingAction(_ sender: Any) {
        if textField.text == "" {
            buttonSave.isEnabled = false
        } else {
            buttonSave.isEnabled = true
        }
    }

    @IBOutlet weak var switchNotification: UISwitch!
    @IBAction func switchAction(_ sender: Any) {
        if switchNotification.isOn {
            datePicker.isEnabled = true
            datePicker.alpha = 1

            UNUserNotificationCenter.current().requestAuthorization(
                    options: [UNAuthorizationOptions.badge, UNAuthorizationOptions.sound, UNAuthorizationOptions.alert],
                    completionHandler: {
                        (bool, error) in
                    }
            )
        } else {
            datePicker.isEnabled = false
            datePicker.alpha = 0
        }
    }

    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var buttonSave: UIBarButtonItem!
    @IBAction func pushSaveButton(_ sender: Any) {
        if let todo = todo {
            todo.name = textField.text!
            todo.isNotification = switchNotification.isOn
            todo.date = datePicker.date
        } else {
            todo = ToDo(name: textField.text!, date: datePicker.date, isNotification: switchNotification.isOn)

            dataArray.insert(todo!, at: 0)
        }

        saveData()

        navigationController?.popToRootViewController(animated: true)
    }


    override func viewDidLoad() {
        if let todo = todo {
            textField.text = todo.name
            switchNotification.isOn = todo.isNotification
            datePicker.date = todo.date
        }

        textChangingAction(self)
        switchAction(self)
    }
}
