//
//  Model.swift
//  ToDoList
//
//  Created by Tanya on 21.03.2024.
//

import Foundation


var items: [[String: Any]] { 
    
    set {
        UserDefaults.standard.setValue(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as?
            [[String: Any]] {
            return array
        } else {
            return []
        }
    }
    
}

func addItem(nameItem: String, isComplited: Bool = false) {
    items.append(["Name": nameItem, "isComplited": isComplited])
    
    
}



func removeItem(at index: Int) {
    items.remove(at: index)
}

func changeStatus(at item: Int) -> Bool {
    items[item] ["isComplited"] = !(items[item] ["isComplited"] as! Bool)
    
    return items[item] ["isComplited"] as! Bool
    
}
