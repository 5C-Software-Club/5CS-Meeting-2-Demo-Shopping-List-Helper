//
//  MainController.swift
//  Shopping List Helper
//
//  Created by Matthew Krager on 10/24/18.
//  Copyright © 2018 Matthew Krager. All rights reserved.
//

import UIKit

// A Controller
class MainController: UIViewController {

    // Our collection of model objects
    // An array of Grocery objects to be used in our table cell
    var shoppingList = [Grocery]()
    
    // Add some items to our shopping list!
    func prepareInitialShoppingList() {
        shoppingList.append(Grocery.init(name: "Lettuce", price: "$0.99", quantity: "x10"))
        // TODO: Let's add more food later!
    }
    
    // HANDLE USER INTERACTION
    // Ran when user taps plus button on top right
    @objc func addButtonTapped() {
        self.promptUserToAddGrocery()
    }
    
    // Ran when users saves their new grocery
    func makeNewGrocery(name: String, quantity: String, price: String) {
        // TODO: make new grocery and add to shoppingList based on parameters
        let newGrocery = Grocery(name: name, price: price, quantity: quantity)
        self.shoppingList.append(newGrocery)
        self.tableView.reloadData()
    }
    
    // CONNECT MODEL TO THE VIEW
    // Returns a view that uses info from the given grocery
    func cellViewForGrocery(grocery: Grocery) -> GroceryTableCellView {
        
        let cellView = newCellView()
        
        // TODO: Connect the Model to the View
        cellView.nameLabel.text = grocery.name
        cellView.priceLabel.text = grocery.price
        cellView.quantityLabel.text = grocery.quantity
        return cellView
    }
    
    
    
    
    
    // Other irrelevant iOS Code
    @IBOutlet var tableView: UITableView!
    
    func newCellView() -> GroceryTableCellView {
        // Creates a GroceryTableCellView for us to use
        guard let cellView = self.tableView.dequeueReusableCell(withIdentifier: "GroceryCell") as? GroceryTableCellView else {
            fatalError()
        }
        return cellView
    }
    
    // Run when the controller starts up
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shopping Cart"

        // Make our add button and place it on the top left corner
        let leftButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addButtonTapped))
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]
        leftButton.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem = leftButton
        
        self.prepareInitialShoppingList()
    }
    
    // Prompts the user to add a new grocery
    // you can ignore most of this code,
    // it justs prompts the user for info about their
    // new grocery (iOS stuff :P)
    func promptUserToAddGrocery() {
        let alertController = UIAlertController(title: "Add a Grocery", message: "", preferredStyle: .alert)
        // add text fields to alert
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Name"
        })
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Price"
        })
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Quantity"
        })
        
        // Save and cancel actions
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            
            // Grabs the textfields from the Alert
            let nameTextField = alertController.textFields![0] as UITextField
            let priceTextField = alertController.textFields![1] as UITextField
            let quantityTextField = alertController.textFields![2] as UITextField
            
            // Creates a new Grocery based off our input
            self.makeNewGrocery(name: nameTextField.text!, quantity: quantityTextField.text!, price: priceTextField.text!)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// Table View Code
extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    // Returns the number of rows for our table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingList.count
    }
    
    // Make a cell for a certain row and returns it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Determines row number we will create cell for
        let rowNumber = indexPath.row
        let grocery = self.shoppingList[rowNumber]
        
        return self.cellViewForGrocery(grocery: grocery)
    }
}
