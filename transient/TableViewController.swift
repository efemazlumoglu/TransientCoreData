//
//  TableViewController.swift
//  transient
//
//  Created by Efe Mazlumoğlu on 9.10.2020.
//

import Foundation
import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
        
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: "section", cacheName: nil)
                fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print(error)
        }
                
                tableView.reloadData()
    }
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
            
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Number")
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: false)
        
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        return fetchRequest
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as UITableViewCell
                
        if let cellNumber = fetchedResultsController?.object(at: indexPath) as? Number {
                    cell.textLabel?.text = "\(cellNumber.number)"
                }
                
                return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController?.sections as [NSFetchedResultsSectionInfo]
                return sectionInfo[section].name
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
                case NSFetchedResultsChangeType.insert:
                    tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: UITableView.RowAnimation.fade)
                    break
                case NSFetchedResultsChangeType.delete:
                    tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: UITableView.RowAnimation.fade)
                    break
                case NSFetchedResultsChangeType.move:
                    break
                case NSFetchedResultsChangeType.update:
                    break
                default:
                    break
                }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                }
                
                switch editingStyle {
                case .delete:
                    
//                    managedObjectContext?.delete((fetchedResultsController?.object(at: indexPath))!)
                    do {
                        try managedObjectContext?.save()
                    } catch {
                        print(error)
                    }
                case .insert:
                    break
                case .none:
                    break
                default:
                    break
                }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
                case NSFetchedResultsChangeType.insert:
                    tableView.insertRows(at: NSArray(object: newIndexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
                    break
                case NSFetchedResultsChangeType.delete:
                    tableView.deleteRows(at: NSArray(object: indexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
                    break
                case NSFetchedResultsChangeType.move:
                    tableView.deleteRows(at: NSArray(object: indexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
                    tableView.insertRows(at: NSArray(object: newIndexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
                    break
                case NSFetchedResultsChangeType.update:
                    tableView.cellForRow(at: indexPath!)
                    break
                default:
                    break
                }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
            
        let newNumber = NSEntityDescription.insertNewObject(forEntityName: "Number", into: managedObjectContext!) as! Number
            
        newNumber.number = NSNumber(value: arc4random_uniform(100))
            
        do {
            try managedObjectContext?.save()
        } catch {
            print(error)
        }
            
        }
}
