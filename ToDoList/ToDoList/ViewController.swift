//
//  ViewController.swift
//  ToDoList
//
//  Created by Tanya on 19.03.2024.
//

import UIKit


// MARK: - ViewController

final class ViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        tableView.backgroundColor = .systemTeal
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (addItemsBtn))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(addEditBtn)
        )
    }
    
    override func viewDidLayoutSubviews () {
        super.viewDidLayoutSubviews ()
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemTeal
        
    }
    
    // MARK: - Button Actions
    
    @objc func addEditBtn() {
        tableView.setEditing(!tableView.isEditing,animated: true)
    }
    
    @objc func addItemsBtn() {
        let alertController = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = Constants.alertPlaceholder
        }
        
        let alertAction1 = UIAlertAction(title: Constants.cancelButtonLabel, style: .default) { _ in }
        let alertAction2 = UIAlertAction(title: Constants.createButtonLabel, style: .cancel) { _ in
            let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath)
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isComleted"] as? Bool) == true {
            cell.imageView?.image = .check
        } else {
            cell.imageView?.image = nil
        }
        cell.backgroundColor = .systemTeal
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // TODO: - Добавить функционал ?
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeStatus(at: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.imageView?.image = .check
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = .uncheck
        }
    }
}

private extension ViewController {
    enum Constants {
        static let title: String = "To Do List"
        static let cancelButtonLabel: String = "Cancel"
        static let createButtonLabel: String = "Create"
        static let cellId: String = "cell"
        static let alertTitle: String = "Create new item"
        static let alertPlaceholder: String = "New item name"
    }
}


