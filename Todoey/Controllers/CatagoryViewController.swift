//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Marcus Whelan on 7/25/18.
//  Copyright © 2018 Marcus Whelan. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {
    
    var catagories = [Catagory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        cell.textLabel?.text = catagories[indexPath.row].name
        return cell
    }
    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = catagories[indexPath.row]
        }
    }
    //MARK: - Data manipulation
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving category, \(error)")
        }
        tableView.reloadData()
    }
    func loadCategories(with request: NSFetchRequest<Catagory> = Catagory.fetchRequest()) {
        do {
            catagories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add new catagories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Catagory(context: self.context)
            newCategory.name = textField.text!
            self.catagories.append(newCategory)
            self.saveCategories()
        }
         alert.addAction(action)
        alert.addTextField { (field) in
            field.placeholder = "Create new category"
            textField = field
        }
        present(alert, animated: true, completion: nil)
    }

}
