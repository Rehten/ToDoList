//
//  ListController.swift
//  ToDoList
//
//  Created by Sysoev Anton on 26.07.2020.
//  Copyright © 2020 REALM. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    @IBAction func pushAddList(_ sender: Any) {
        let newToDo = ToDo(name: "New ToDo", date: Date(), isNotification: false)

        dataArray.append(newToDo)

        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let todo = dataArray[indexPath.row]

        cell.textLabel?.text = todo.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDoSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoSegue" {
            let todo = dataArray[tableView.indexPathForSelectedRow!.row]

            (segue.destination as! ToDoController).todo = todo
        }
    }
}
