//
//  ShoppingTableViewController.swift
//  ShoppingList
//
//  Created by Matthew O'Connor on 9/27/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit
import CoreData

class ShoppingTableViewController: UITableViewController, ShoppingTableViewCellDelegate {
    func buttonTapped(_ sender: ShoppingTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let shopping = ShoppingController.shared.fetchResultsController.object(at: indexPath)
        ShoppingController.shared.toggle(shopping: shopping)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingController.shared.fetchResultsController.delegate = self
    }

    @IBAction func newItemButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add item", message: "Add an item to your shopping list.", preferredStyle: .alert)
        
        let addButton = UIAlertAction(title: "Add item", style: .default) {(action) in
            guard let newItem = alert.textFields?[0].text else {return}
            ShoppingController.shared.create(name: newItem, isComplete: false)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (_) in
            
        }
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
    
    
    
    
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionNumber = Int(ShoppingController.shared.fetchResultsController.sections?[section].name ?? "0")
        
        if sectionNumber == 1 {
            return "Completed"
        } else {
            return "Incomplete"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ShoppingController.shared.fetchResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingController.shared.fetchResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell()}
        let shopping = ShoppingController.shared.fetchResultsController.object(at: indexPath)
        cell.delegate = self
        cell.updateViews(shopping: shopping)
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let shopping = ShoppingController.shared.fetchResultsController.object(at: indexPath)
            ShoppingController.shared.delete(shopping: shopping)

        }    
    }

}

extension ShoppingTableViewController: NSFetchedResultsControllerDelegate {
    // Conform to the NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //sets behavior for cells
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
}

