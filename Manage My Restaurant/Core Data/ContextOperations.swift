//
//  ContextOperations.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 10/04/2023.
//

import Foundation
import CoreData
import CloudKit
import SwiftUI

class ContextOperations {
    
//    Common NSManagedObjectContext operations
    
    static func save(_ viewContext: NSManagedObjectContext) {
        guard viewContext.hasChanges else {return}

        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func batchCreate (_ context: NSManagedObjectContext ,_ numberOfTables: Int) {
        
        for item in 1...(numberOfTables) {
            
            let newTable = Table(context: context)
            newTable.tableNumber = Int64(item)
            newTable.seatingCapacity = 2
            
        }
        
        ContextOperations.save(context)
        
    }
    
    static func delete(at offsets: IndexSet, fetchResult: FetchedResults<NSManagedObject>, viewContex: NSManagedObjectContext ) {
    
        for index in offsets {
            
            let objectToBeDeleted = fetchResult[index]
            viewContex.delete(objectToBeDeleted)
        }
        save(viewContex)
    }
    
    static func batchDelete(_ entityName: String ,_ viewContext: NSManagedObjectContext) {
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: entityName))
        deleteRequest.resultType = .resultTypeObjectIDs

        do {
            let deleteResult = try viewContext.execute(deleteRequest) as? NSBatchDeleteResult
            
            if let objectIDs = deleteResult?.result as? [NSManagedObjectID] {
        
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs], into: [viewContext])
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        save(viewContext)
    }
    
    static func checkAndRemoveDuplicateTables(_ viewContext: NSManagedObjectContext) {
        
        let request = NSFetchRequest<Table>(entityName: "Table")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
        request.predicate = NSPredicate(format: "entity = %@", Table.entity())
        
        var result: [Table] = []
        
        do {
            result = try viewContext.fetch(request)
        } catch let error {
            print("Error fetching tables \(error)")
        }
        
        result.forEach { table in
            
            findDuplicate(table: table, viewContext)
        }
        
        save(viewContext)
        
    }
    
    static func findDuplicate(table: Table, _ viewContext: NSManagedObjectContext) {
        
        let request = NSFetchRequest<Table>(entityName: "Table")
        request.sortDescriptors = []
        request.predicate = NSCompoundPredicate(type: .and, subpredicates:
                                                    [NSPredicate(format: "entity = %@", Table.entity()),
                                                     NSPredicate(format: "tableNumber = %i", table.tableNumber)])
        
        var result: [Table] = []
        
        do {
            result = try viewContext.fetch(request)
        } catch let error {
            print("Error fetching table: \(table.tableNumber) and error:  \(error)")
        }
        
        if result.count > 1 {
            let winner = result.first!
            result.removeFirst()
            
            result.forEach { redundantTable in
                if let guestSet = redundantTable.toGuest {
                    for case let guest as Guest in guestSet {
                        winner.addToToGuest(guest)
                        redundantTable.removeFromToGuest(guest)
                    }
                }
                viewContext.delete(redundantTable)
            }
        }
        
    }
   
}



