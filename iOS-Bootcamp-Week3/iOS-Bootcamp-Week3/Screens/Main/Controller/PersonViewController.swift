//
//  PersonalViewController.swift
//  iOS-Bootcamp-Week3
//
//  Created by Asım can Yağız on 10.10.2022.
//

import UIKit

class PersonalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Core data variable for helps us the check data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [FavoritesItems]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Favorites"
        getAllItems()
        
        //We add and delegtade table view to screen
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
    }
    
    //This function when you check another tab and come back the this tab will be active like viewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Favorites"
        getAllItems()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    
    //This function calculate the count of models and return Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    //This function create cell for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.track
        return cell
    }
    
    //This function triggerd methods for selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = models[indexPath.row]
        
        //Sheet variable and actions weill help us to tregger alert screen and guide the user modified favorites
        let sheet = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            //Alert for sheet
            let alert = UIAlertController(title: "Edit Item",
                                          message: "Edit Your item",
                                          preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.track
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first , let newName = field.text, !newName.isEmpty else {
                    return
                }
                
                self?.updateItem(item: item, newName: newName)
                
            }))
            self.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
    }
    
    
    //MARK: - Core Data

    //this function call the items in core data
    func getAllItems () {
        
        do {
            models = try context.fetch(FavoritesItems.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
        
    }
    
    //This functions create item in core data
    func createItem(name: String){
        let newItem = FavoritesItems(context: context)
        newItem.track = name
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    //this function delete the items in core data
    func deleteItem(item: FavoritesItems) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    //this function save the items in core data
    func updateItem(item: FavoritesItems, newName: String) {
        item.track = newName
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }

}
