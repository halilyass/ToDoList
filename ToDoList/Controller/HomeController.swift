//
//  ViewController.swift
//  ToDoList
//
//  Created by Halil YAŞ on 30.12.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate


class HomeController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var toDoTable: UITableView!
    
    var toDoList : [Entity] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTable.delegate = self
        toDoTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        uploadData()
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addVC") else { return }
        vc.modalPresentationStyle = .fullScreen
        newPresent(vc)
    }
    
    //MARK: - Helpers
    
    func uploadData() {
        
        self.fetchData { complete in
            if complete {
                
                if toDoList.count >= 1 {
                    toDoTable.isHidden = false
                } else {
                    
                    toDoTable.isHidden = true
                }
            }
        }
        toDoTable.reloadData()
    }
}

//MARK: - UITableViewDelegate

extension HomeController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexpath in
            self.removeData(indexpath: indexpath)
            self.uploadData()
        }
        
        delete.backgroundColor = .red
        
        //Update Action
        
        let update = UITableViewRowAction(style: .normal, title: "Add") { action, indexPath in
            self.update(indexPath: indexPath)
            self.toDoTable.reloadRows(at: [indexPath], with: .automatic)
        }
        
        update.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return [delete,update]
    }
    
}

//MARK: - UITableViewDataSource

extension HomeController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeCell else { return UITableViewCell() }
        
        let list = toDoList[indexPath.row]
        
        cell.configure(entity: list)
        return cell
    }
    
    
}

//MARK: - COREDATA

extension HomeController {
    
    func update(indexPath : IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let selectedIndex = toDoList[indexPath.row]
        
        if selectedIndex.targetNumber < selectedIndex.targetCompletion {
            selectedIndex.targetNumber += 1
        } else {
            return
        }
        
        do {
            
            try managedContext.save()
            
        } catch {
            debugPrint("DEBUG: Error \(error.localizedDescription)")
            
        }
        
    }
    
    func removeData(indexpath : IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(toDoList[indexpath.row])
        
        do {
            
            try managedContext.save()
            
            self.toDoList.remove(at: indexpath.row)
            self.toDoTable.deleteRows(at: [indexpath], with: .automatic)
            
        } catch {
            debugPrint("Error \(error.localizedDescription)")
        }
    }
    
    func fetchData(completionHandler: (_ complete: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Entity>(entityName: "Entity")
        
        do {
            toDoList = try managedContext.fetch(fetchRequest)
            print("Complete")
            completionHandler(true)
        } catch {
            debugPrint("Error \(error.localizedDescription)")
            completionHandler(false)
        }
    }
}

