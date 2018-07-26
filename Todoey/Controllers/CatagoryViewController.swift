//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Marcus Whelan on 7/25/18.
//  Copyright © 2018 Marcus Whelan. All rights reserved.
//

import UIKit
import RealmSwift

class CatagoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        return cell
    }
    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    //MARK: - Data manipulation
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category, \(error)")
        }
        tableView.reloadData()
    }
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Add new catagories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
         alert.addAction(action)
        alert.addTextField { (field) in
            field.placeholder = "Create new category"
            textField = field
        }
        present(alert, animated: true, completion: nil)
    }

}
