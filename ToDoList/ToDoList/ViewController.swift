//
//  ViewController.swift
//  ToDoList
//
//  Created by Tanya on 19.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemTeal
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.addSubview (tableView)
        tableView.dataSource = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,target: self, action: #selector (addItemsBtn))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self, action: #selector(addEditBtn))
    }
    
    
    override func viewDidLayoutSubviews () {
        super.viewDidLayoutSubviews ()
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemTeal
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeStatus(at: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.imageView?.image = .check
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = nil
        }
        
    }

    @objc func addEditBtn() {
    
        tableView.setEditing(!tableView.isEditing,animated: true)
}

    
    @objc func addItemsBtn() {
        
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "New item name"
                
            }
            
            
            let alertAction1 = UIAlertAction(title: "Cancel", style: .default)
            { alert in
            }
            let alertAction2 = UIAlertAction(title: "Create", style: .cancel)
            { alert in
                
                let newItem = alertController.textFields![0].text
                addItem(nameItem: newItem!)
                self.tableView.reloadData()
            }
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)

            present(alertController, animated: true, completion: nil)
        }
}
  //MARK: - Extension
        
  extension ViewController: UITableViewDataSource {
      
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isComleted"] as? Bool) == true {
            cell.imageView?.image = .check
        } else {
            cell.imageView?.image = nil
        }
        
        return cell
    }
}

func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
         removeItem(at: indexPath.row)
         tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
         
     }
 }

 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
                                                          
    if changeStatus(at: indexPath.row) == true {
        tableView.cellForRow(at: indexPath)?.imageView?.image = .check
    } else {
        tableView.cellForRow(at: indexPath)?.imageView?.image = nil
    }
    
}
