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
        performSegue(withIdentifier: "toDoSegue", sender: self)
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
        if todo.isNotification {
            cell.detailTextLabel?.text = todo.dateString

            if todo.isDateActual {
                cell.detailTextLabel?.textColor = .green
            } else {
                cell.detailTextLabel?.textColor = .red
            }
        } else {
            cell.detailTextLabel?.text = ""
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDoSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoSegue" {
            if tableView.indexPathForSelectedRow != nil {
                let todo = dataArray[tableView.indexPathForSelectedRow!.row]
                (segue.destination as! ToDoController).todo = todo
            } else {
                (segue.destination as! ToDoController).todo = nil
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataArray[indexPath.row].isNotification = false
            dataArray.remove(at: indexPath.row)

            saveData()

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
